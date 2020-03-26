require_relative '../../../app/ledger'

module ExpenseTracker
  RSpec.describe Ledger, :db, :aggregate_failures do
    let(:ledger) { described_class.new }

    let(:expense) do
      {
        'payee' => 'Starbucks',
        'amount' => 5.75,
        'date' => '2020-01-01'
      }
    end

    describe '#record' do
      context 'with a valid expense' do
        it 'successfully saves the expense in the DB' do
          result = ledger.record(expense)

          expect(result).to be_success
          expect(DB[:expenses].all).to match [a_hash_including(
            id: result.expense_id,
            payee: 'Starbucks',
            amount: 5.75,
            date: Date.iso8601('2020-01-01')
          )]
        end

        it "uses today's date if expense lacks one" do
          expense.delete('date')

          result = ledger.record(expense)
          saved = DB[:expenses].find(id: result.expense_id).first

          expect(result).to be_success
          expect(saved[:date]).to eq Date.iso8601
        end
      end

      context 'with an invalid expense' do
        def expect_failure_with_message(result, message)
          expect(result).to_not be_success
          expect(result.expense_id).to eq nil
          expect(result.error_message).to include(message)

          expect(DB[:expenses].count).to eq 0
        end

        it 'rejects the expense as invalid when it lacks a payee' do
          expense.delete('payee')

          result = ledger.record(expense)

          expect_failure_with_message(result, '`payee` is required')
        end

        it 'rejects the expense as invalid when it lacks an amount' do
          expense.delete('amount')

          result = ledger.record(expense)

          expect_failure_with_message(result, '`amount` is required')
        end
      end
    end

    describe '#expenses_on' do
      it 'returns all expenses for the provided date' do
        result1 = ledger.record(expense.merge('date' => '2020-01-02'))
        result2 = ledger.record(expense.merge('date' => '2020-01-02'))
        _result3 = ledger.record(expense.merge('date' => '2020-01-03'))

        expect(ledger.expenses_on('2020-01-02')).to contain_exactly(
          a_hash_including(id: result1.expense_id),
          a_hash_including(id: result2.expense_id)
        )
      end

      it 'returns a blank array when tehere are no matching expenses' do
        expect(ledger.expenses_on('2020-01-02')).to eq []
      end
    end
  end
end
