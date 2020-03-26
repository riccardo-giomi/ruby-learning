RSpec.configure do |c|
  c.before(:suite) do
    Sequel.extension :migration
    Sequel::Migrator.run(DB, 'db/migrations')
    DB[:expenses].truncate

    FileUtils.mkdir_p('log')
    FileUtils.rm('log/sequel.log', force: true)
    require 'logger'
    DB.loggers << Logger.new('log/sequel.log')
  end

  c.around(:example, :db) do |example|
    DB.log_info("Starting example: #{example.description}")
    DB.transaction(rollback: :always) do example.run end
    DB.log_info("Ending example: #{example.description}")
  end
end
