module FastSeeder
  module Seeders
    class CsvSeeder < BaseSeeder
      def initialize(model_class, declared_columns, default_values, csv_file)
	super(model_class, declared_columns, default_values)
	@csv_file = File.join(FastSeeder.seeds_path, csv_file)
      end


      private

      def specific_values
	CSV.read(@csv_file)
      end

    end
  end
end
