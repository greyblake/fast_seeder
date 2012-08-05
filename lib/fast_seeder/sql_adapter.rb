module FastSeeder
  class SqlAdapter
    def initialize(conn, record_set)
      @conn       = conn
      @record_set = record_set
    end

    def insert!
      sql = build_sql
      @conn.execute(sql)
    end


    private

    def build_sql
      columns_str = build_columns_str
      values_str  = build_values_str
      "INSERT INTO #{@record_set.table} (#{columns_str}) VALUES #{values_str}"
    end

    def build_columns_str
      column_names = @record_set.columns
      column_names << 'created_at' if process_created_at?
      column_names << 'updated_at' if process_updated_at?
      column_names.join(", ")
    end

    def build_values_str
      values = @record_set.values.map do |vals|
        build_record_values_str(vals)
      end
      values.join(", ")
    end

    def build_record_values_str(values)
      vals = values.dup
      vals << Time.zone.now if process_created_at?
      vals << Time.zone.now if process_updated_at?
      quoted_vals = vals.map { |val| @conn.quote(val) }
      joint_vals =  quoted_vals.join(", ")
      "(#{joint_vals})"
    end


    def process_created_at?
      @process_created_at ||= process_timestamp?('created_at')
    end

    def process_updated_at?
      @process_updated_at ||= process_timestamp?('updated_at')
    end

    def process_timestamp?(column_name)
      @record_set.model_class.column_names.include?(column_name.to_s) &&
        !@record_set.columns.include?(column_name.to_s)
    end

  end
end
