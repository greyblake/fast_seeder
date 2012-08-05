module FastSeeder
  module Adapters
    extend ActiveSupport::Autoload

    autoload :PostgresqlAdapter
    autoload :MysqlAdapter
    autoload :SqliteAdapter
    autoload :BaseAdapter
  end
end
