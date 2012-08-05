module FastSeeder
  class RecordSet
    attr_reader :columns, :values, :model_class

    def initialize(model_class, columns)
      @model_class = model_class
      @columns    = columns.map(&:to_s)
      @values     = []
    end

    def <<(values)
      @values << values
    end

    def table
      @model_class.table_name
    end
  end
end
