# FastSeeder [![Build Status](https://secure.travis-ci.org/smartdict/smartdict-core.png)](http://travis-ci.org/greyblake/fast_seeder)

By [Sergey Potapov](https://github.com/greyblake)

Speeds up seeding database using multiple SQL inserts!

## Installation

Add to Gemfile:

```ruby
gem "fast_seeder"
```


## Usage

### Seeding from CSV file

Lets say you have CSV file:

```csv db/seeds/cities/ukraine.csv

Kharkov,1654
Lviv,1240
Kiev,600

```

You can populate DB with using FastSeeder:

```ruby db/seeds.rb

# Seeding from CSV file:
FastSeeder.seed_csv!(City, "cities/ukraine.csv", :name, :founded_in, :country => "Ukraine")

```

Technically it equals to:

```ruby

City.create(:name => "Kharkov", :founded_in => 1654, :country => "Ukraine")
City.create(:name => "Lviv"   , :founded_in => 1240, :country => "Lviv")
City.create(:name => "Kiev"   , :founded_in => 600 , :country => "Lviv")

```

But does the job faster using only one SQL query instead of three.

### Seeding in place

The next example is equivalent to showed above one, but uses inline data
without CSV file:

```ruby

# Seeding in place:
FastSeeder.seed!(City, :name, :founded_in, :country => "Ukraine") do
  record "Kharkov", 1654
  record "Lviv"   , 1240
  record "Kiev"   , 600
end

```
