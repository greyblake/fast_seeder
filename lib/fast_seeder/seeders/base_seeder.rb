module FastSeeder
  module Seeders
    class BaseSeeder
      def initialize(model_class, declared_columns, default_values)
	@model_class      = model_class
	@declared_columns = declared_columns

        # Ordered hash is necessary to not mess columns and wrong values
	@default_values = ActiveSupport::OrderedHash[*default_values.to_a.flatten]
      end

      def seed!
	record_set = RecordSet.new(@model_class, columns)
	specific_values.each do |record_vals|
	  record_set << merged_values_for(record_vals)
	end
	adapter = adapter_class.new(conn, record_set)
	adapter.insert!
      end

      private

      def specific_values
	raise NotImplementedError
      end


      def columns
	@columns ||= @declared_columns + @default_values.keys
      end

      def merged_values_for(specific_vals)
	specific_vals + @default_values.values
      end

      def adapter_class
	case conn.adapter_name
	when "PostgreSQL"      then Adapters::PostgresqlAdapter
	when "Mysql2", "MySQL" then Adapters::MysqlAdapter
	when "SQLite"          then Adapters::SqliteAdapter
	else raise("Unsupported connection adapter: #{conn.adapter_name}")
	end
      end

      def conn
	ActiveRecord::Base.connection
      end
    end
  end
end
