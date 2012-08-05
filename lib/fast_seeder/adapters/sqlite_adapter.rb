module FastSeeder
  module Adapters
    class SqliteAdapter < BaseAdapter

      private

      # Build something similar to this:
      #   INSERT INTO 'tablename' (column1, column2)
      #   SELECT 'data1' AS 'column1', 'data2' AS 'column2'
      #   UNION SELECT 'data3', 'data4'
      #   UNION SELECT 'data5', 'data6'
      def build_sql
	values_str  = build_values_str
	columns_str = build_columns_str
	"INSERT INTO '#{@record_set.table}' (#{columns_str})\n#{values_str}"
      end

      # Build values part like:
      #   SELECT 'data1' AS 'column1', 'data2' AS 'column2'
      #   UNION SELECT 'data3', 'data4'
      #   UNION SELECT 'data5', 'data6'
      def build_values_str
	first_record_vals = @record_set.values.first
	other_vals        = @record_set.values[1..-1]
	first_str = build_first_record_srt(first_record_vals)
	other_str = build_other_records_str(other_vals)
	"#{first_str}\n#{other_str}"
      end

      # Build first line of values part like:
      #   SELECT 'data1' AS 'column1', 'data2' AS 'column2'
      def build_first_record_srt(record_vals)
	pairs = ActiveSupport::OrderedHash[@record_set.columns.zip(record_vals)]
	pairs['created_at'] = Time.zone.now if process_created_at?
	pairs['updated_at'] = Time.zone.now if process_updated_at?
	joint_pairs = pairs.map do |column, value|
	  quoted_value = @conn.quote(value)
	  "#{quoted_value} AS '#{column}'"
	end
	data_str = joint_pairs.join(", ")
	"SELECT #{data_str}"
      end

      # Build values part like this:
      #   UNION SELECT 'data3', 'data4'
      #   UNION SELECT 'data5', 'data6'
      def build_other_records_str(records_vals)
	records_vals.map do |record_vals|
	  build_record_str(record_vals)
	end.join("\n")
      end

      # Build line of values part like:
      #   UNION SELECT 'data5', 'data6'
      def build_record_str(record_vals)
	vals = record_vals.dup
	vals << Time.zone.now if process_created_at?
	vals << Time.zone.now if process_updated_at?
	data = vals.map { |val| @conn.quote(val) }.join(", ")
	"UNION SELECT #{data}"
      end

    end
  end
end
