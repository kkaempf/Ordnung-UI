Ordnung::Application.boot(:db) do
  init do
    require 'rom-sql'

    connection = Sequel.connect('sqlite://ordnung.db')
    register('db.connection', connection)
    register('db.config', ROM::Configuration.new(:sql, connection))
  end
end