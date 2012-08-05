require 'csv'
require 'active_support/all'

module FastSeeder
  extend self
  extend ActiveSupport::Autoload

  autoload :Seeders
  autoload :SqlAdapter
  autoload :RecordSet


  def self.seed_csv!(model_class, csv_file, *colums_and_default_values)
    default_values = colums_and_default_values.extract_options!
    columns        = colums_and_default_values
    seeder = Seeders::CsvSeeder.new(model_class, columns, default_values, csv_file)
    seeder.seed!
  end

  def self.seed!(model_class, *colums_and_default_values, &block)
    default_values = colums_and_default_values.extract_options!
    columns        = colums_and_default_values
    seeder = Seeders::InlineSeeder.new(model_class, columns, default_values, block)
    seeder.seed!
  end


  def seeds_path
    Rails.root + "db/seeds"
  end
end
