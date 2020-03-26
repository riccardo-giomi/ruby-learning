require_relative '../config/sequel'

module ExpenseTracker
  RecordResult = Struct.new(:success?, :expense_id, :error_message)

  class Ledger
    def record(expense)
      %w[payee amount].each do |field|
        unless expense.key?(field)
          message = "Invalid expense: `#{field}` is required"
          return RecordResult.new(false, nil, message)
        end
      end

      expense['date'] = Date.iso8601 unless expense.key?('date')

      DB[:expenses].insert(expense)
      id = DB[:expenses].max(:id)
      RecordResult.new(true, id, nil)
    end

    def expenses_on(date)
      DB[:expenses].where(date: date).all
    end
  end
end
