$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "fast_seeder/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "fast_seeder"
  s.version     = FastSeeder::VERSION
  s.authors     = ["Sergey Potapov"]
  s.email       = ["blake131313@gmail.com"]
  s.homepage    = "https://github.com/greyblake/fast_seeder"
  s.summary     = "Speeds up seeding database using multiple SQL inserts"
  s.description = "Speeds up seeding database using multiple SQL inserts"

  s.files = Dir["{lib}/**/*"] + ["LGPL-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.0"
end
