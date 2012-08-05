require 'csv'
require 'active_support/all'

# Populates database with seeds using multiple inserts.
#
# Usage:
#
# CSV file:
#   Kharkov,1654
#   Lviv,1240
#   Kiev,600
#
# Seeding from CSV file:
#   FastSeeder.seed_csv!(City, "cities/ukraine.csv", :name, :founded_in, :country => "Ukraine")
#
# Seeding in place:
#   FastSeeder.seed!(City, :name, :founded_in, :country => "Ukraine") do
#     record "Kharkov", 1654
#     record "Lviv"   , 1240
#     record "Kiev"   , 600
#   end
module FastSeeder
  extend self
  extend ActiveSupport::Autoload

  autoload :Seeders
  autoload :Adapters
  autoload :RecordSet
  autoload :Error

  # Seed database with data from CSV file
  # Usage:
  #   FastSeeder.seed_csv!(City, "cities/ukraine.csv", :name, :founded_in, :country => "Ukraine")
  #
  # @param [ActiveRecord::Base] model_class model which needs to be seeded
  # @param [String] csv_file path to CSV file relative to db/seeds
  # @param [*] colums_and_default_values
  def self.seed_csv!(model_class, csv_file, *colums_and_default_values)
    default_values = colums_and_default_values.extract_options!
    columns        = colums_and_default_values
    seeder = Seeders::CsvSeeder.new(model_class, columns, default_values, csv_file)
    seeder.seed!
  end

  # Seeds database with data defined in block with "record" method.
  # Usage:
  #   FastSeeder.seed!(City, :name, :founded_in, :country => "Ukraine") do
  #     record "Kharkov", 1654
  #     record "Lviv"   , 1240
  #     record "Kiev"   , 600
  #   end
  # @param [ActiveRecord::Base] model_class model which needs to be seeded
  # @param [*] colums_and_default_values
  def self.seed!(model_class, *colums_and_default_values, &block)
    unless block_given?
      raise FastSeeder::Error.new("`FastSeeder.seed!` requires a block to be passed")
    end

    default_values = colums_and_default_values.extract_options!
    columns        = colums_and_default_values
    seeder = Seeders::InlineSeeder.new(model_class, columns, default_values, block)
    seeder.seed!
  end


  # Path to basic seeds directory
  def seeds_path
    Rails.root + "db/seeds"
  end
end
