Ordnung::Application.boot(:db) do
  init do
    require 'rom-sql'

    db_name = "sqlite://ordnung_#{ENV['APP_ENV']}.db"
    register('db.name', db_name)
    connection = Sequel.connect(db_name)
    register('db.connection', connection)
    register('db.config', ROM::Configuration.new(:sql, connection))
  end
end
