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

Lets say you have CSV file `db/seeds/cities/ukraine.csv`:

```csv
Kharkov,1654
Lviv,1240
Kiev,600
```

You can populate DB with it using FastSeeder:

```ruby
# Seeding from CSV file:
FastSeeder.seed_csv!(City, "cities/ukraine.csv", :name, :founded_in, :country => "Ukraine")
```

Technically it equals to:

```ruby
City.create(:name => "Kharkov", :founded_in => 1654, :country => "Ukraine")
City.create(:name => "Lviv"   , :founded_in => 1240, :country => "Ukraine")
City.create(:name => "Kiev"   , :founded_in => 600 , :country => "Ukraine")
```

But does the job faster using only one SQL query instead of three.
As you also noticed it expects you to pass model class, path to CSV file(located in `db/seeds`),
CSV columns, and default values.

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

## Supported database adapters

* PostgreSQL
* MySQL(mysql, mysql2)
* SQLite3

## Running specs

```
rake spec:all               # run specs with all supported adapters
rake spec:mysql             # run specs with mysql adapter
rake spec:mysql2            # run specs with mysql2 adapter
rake spec:postgresql        # run specs with postgresql adapter
rake spec:sqlite3           # run specs with sqlite3 adapter
```

## Credits

* [Sergey Potapov](https://github.com/greyblake) - creator and maintainer

## License

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/lgpl.txt>
