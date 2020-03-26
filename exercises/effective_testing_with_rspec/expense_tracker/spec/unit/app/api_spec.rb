require 'rack/test'

require_relative '../../../app/api'

module ExpenseTracker
  RSpec.describe API, fail_if_slower_than: 0.01 do
    include Rack::Test::Methods

    let(:ledger) { instance_double('ExpenseTracker::Ledger') }

    def app
      API.new(ledger: ledger)
    end

    def response_data
      JSON.parse(last_response.body)
    end

    def response_data_xml
      Ox.parse_obj(last_response.body)
    end

    describe 'GET /expenses/:date' do
      context 'when expenses exist on the given date' do
        before do
          allow(ledger).to receive(:expenses_on)
            .with('2019-12-31')
            .and_return(%w[expense1 expense2])
        end

        it 'returns the expense records' do
          get '/expenses/2019-12-31'
          expect(response_data).to eq %w[expense1 expense2]
        end

        it 'returns the expense records as JSON by default' do
          get '/expenses/2019-12-31'
          expect(last_response.media_type).to eq 'application/json'
        end

        it 'responds with 200 (OK)' do
          get '/expenses/2019-12-31'
          expect(last_response.status).to eq 200
        end

        it 'can respond with XML' do
          header 'Accept', 'text/xml'
          get '/expenses/2019-12-31'

          expect(response_data_xml).to eq %w[expense1 expense2]
        end

        it 'can respond with XML and the correct media-type' do
          header 'Accept', 'text/xml'
          get '/expenses/2019-12-31'
          expect(last_response.media_type).to eq 'text/xml'
        end

        it 'responds with XML and status 200 (OK)' do
          header 'Accept', 'text/xml'
          get '/expenses/2019-12-31'
          expect(last_response.status).to eq 200
        end
      end

      context 'when an unknown format is requested' do
        it 'responds with 406 (Not Acceptable)' do
          header 'Accept', 'text/csv'
          get '/expenses/2019-12-31'

          expect(last_response.status).to eq 406
        end
      end

      context 'when there are no expenses on the given date' do
        before do
          allow(ledger).to receive(:expenses_on)
            .with('2019-12-31')
            .and_return([])
        end

        it 'returns and empty array as JSON' do
          get '/expenses/2019-12-31'
          expect(response_data).to be_empty
        end

        it 'responds with 200 (OK)' do
          get '/expenses/2019-12-31'
          expect(last_response.status).to eq 200
        end
      end
    end

    describe 'POST /expenses' do
      let(:expense) { {'some' => 'data'} }
      let(:request_data) { JSON.generate(expense) }

      context 'when the expense is succesfully recorded' do
        before do
          allow(ledger).to receive(:record)
            .with(expense)
            .and_return(RecordResult.new(true, 417, nil))
        end

        it 'returns the expense id' do
          header 'Content-type', 'application/json'
          post '/expenses', request_data
          expect(response_data).to include('expense_id' => 417)
        end

        it 'responds with 200 (OK)' do
          header 'Content-type', 'application/json'
          post '/expenses', request_data
          expect(last_response.status).to eq 200
        end

        it "supports data with Content-type 'text/xml'" do
          request_data = Ox.dump(expense)

          header 'Content-type', 'text/xml'
          post '/expenses', request_data
          expect(last_response.status).to eq 200
        end
      end

      context 'with an unknown request data format' do
        it 'responds with 415 (Unsupported Media Type)' do
          header 'Content-type', 'text/csv'
          post '/expenses', 'a,b;'
          expect(last_response.status).to eq 415
        end
      end

      context 'with an invalid request data format' do
        it 'responds with 422 (Unprocessable Entity) for invalid JSON' do
          header 'Content-type', 'application/json'
          post '/expenses', 'Not a JSON!'
          expect(last_response.status).to eq 422
        end

        it 'responds with an error message for invalid JSON' do
          header 'Content-type', 'application/json'
          post '/expenses', 'Not a JSON!'
          expect(last_response.body).to include('Invalid data format')
        end

        it 'responds with 422 (Unprocessable Entity) for invalid XML' do
          header 'Content-type', 'text/xml'
          post '/expenses', 'Not an XML!'
          expect(last_response.status).to eq 422
        end

        it 'responds with an error message for invalid XML' do
          header 'Content-type', 'text/xml'
          post '/expenses', 'Not an XML!'
          expect(last_response.body).to include('Invalid data format')
        end
      end

      context 'when the expense fails validation' do
        before do
          allow(ledger).to receive(:record)
            .with(expense)
            .and_return(RecordResult.new(false, nil, 'Expense incomplete'))
        end

        it 'returns an error message' do
          header 'Content-type', 'application/json'
          post '/expenses', request_data
          expect(response_data).to include('error' => 'Expense incomplete')
        end
      end
    end
  end
end
