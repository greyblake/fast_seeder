module FastSeeder
  module Seeders
    class InlineSeeder < BaseSeeder
      class DataContext
	attr_reader :records

	def initialize(data_block)
	  @records = []
	  instance_eval(&data_block)
	end

	def record(*args)
	  @records << args
	end
      end


      def initialize(model_class, declared_columns, default_values, data_block)
	super(model_class, declared_columns, default_values)
	@data_block       = data_block
      end


      private

      def specific_values
	DataContext.new(@data_block).records
      end

    end
  end
end
