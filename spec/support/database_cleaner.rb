RSpec.configure do |config|
  # Database Cleaner config
  db = Sequel.connect(ENV.fetch('DATABASE_URL'))
  DatabaseCleaner[:sequel].db = db

  static_info_tables = %w()

  config.before(:suite) do
    DatabaseCleaner[:sequel].clean_with :truncation, { except: static_info_tables }
  end

  # start the transaction strategy as examples are run
  config.around(:each) do |example|
    DatabaseCleaner[:sequel].cleaning do
      example.run
    end
  end

end

