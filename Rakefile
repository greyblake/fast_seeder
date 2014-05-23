#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

Bundler::GemHelper.install_tasks

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task 'db:rebuild' => ['db:drop', 'db:create', 'db:migrate', 'db:seed']
Rake::Task[:spec].enhance ['db:rebuild', 'app:db:test:prepare']

namespace :spec do
  desc "run specs with postgresql adapter"
  task :postgresql do
    ENV['ADAPTER'] = 'postgresql'
    ENV['RAILS_ENV'] = 'test'
    Rake::Task[:spec].invoke
  end

  desc "run specs with mysql adapter"
  task :mysql do
    ENV['ADAPTER'] = 'mysql'
    Rake::Task[:spec].invoke
  end

  desc "run specs with mysql2 adapter"
  task :mysql2 do
    ENV['ADAPTER'] = 'mysql2'
    Rake::Task[:spec].invoke
  end

  desc "run specs with sqlite3 adapter"
  task :sqlite3 do
    ENV['ADAPTER'] = 'sqlite3'
    Rake::Task[:spec].invoke
  end

  desc "run specs with all supported adapters"
  task :all do
    adapters = %w(postgresql mysql mysql2 sqlite3)
    adapters.each do |adapter|
      puts "=" * 80
      puts adapter.center(80)
      puts "=" * 80
      system "rake spec:#{adapter}"
    end
  end
end


task :default => 'spec:all'
