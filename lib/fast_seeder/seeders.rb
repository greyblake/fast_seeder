module FastSeeder
  module Seeders
    extend ActiveSupport::Autoload

    autoload :BaseSeeder
    autoload :CsvSeeder
    autoload :InlineSeeder
  end
end
