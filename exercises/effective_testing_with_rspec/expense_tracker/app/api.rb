require 'sinatra/base'
require 'json'
require 'ox' # for XML requests/responses
require_relative 'ledger'

module ExpenseTracker
  class API < Sinatra::Base
    def initialize(ledger: Ledger.new)
      @ledger = ledger
      super
    end

    get '/expenses/:date', provides: :json do
      pass unless request.accept? 'application/json'
      JSON.generate(@ledger.expenses_on(params['date']))
    end

    get '/expenses/:date', provides: :xml do
      pass unless request.accept? 'text/xml'
      Ox.dump(@ledger.expenses_on(params['date']))
    end

    get '/expenses/:date' do
      status 406 # Not Acceptable
      "Cannot serve in the accepted formats (only: 'application/json' and 'text/xml')"
    end

    post '/expenses' do
      case request.media_type
      when 'application/json'
        expense = JSON.parse(request.body.read)
      when 'text/xml'
        expense = Ox.parse_obj(request.body.read)
      else
        status 415 # Unsupported Media Type
        return "Content-type: #{request.media_type} not supported (only: 'application/json' and 'text/xml')"
      end

      result = @ledger.record(expense)

      JSON.generate('expense_id' => result.expense_id)
      if result.success?
        JSON.generate('expense_id' => result.expense_id)
      else
        status 422 # Unprocessable Entity
        JSON.generate('error' => result.error_message)
      end
    end

    error JSON::ParserError, Ox::ParseError do
      status 422
      'Invalid data format'
    end
  end
end
