# FastSeeder

```ruby

# Seeding from CSV file:
FastSeeder.seed_csv!(City, "cities/ukraine.csv", :name, :founded_in, :country => "Ukraine")

# Seeding in place:
FastSeeder.seed!(City, :name, :founded_in, :country => "Ukraine") do
  record "Kharkov", 1654
  record "Lviv"   , 1240
  record "Kiev"   , 600
end

```
