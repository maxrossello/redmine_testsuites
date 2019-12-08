require 'byebug'
require 'byebug/breakpoint'

namespace :redmine do
  
  desc 'Debug all Redmine tests along with all the plugins tests.'
  task :byebug do
    Rake::Task["redmine:byebug:all"].invoke
  end

  namespace :byebug do
    desc 'Debug all Redmine tests along with all the plugins tests.'
    task :all do
      Rake::Task["redmine:byebug:units"].invoke
      Rake::Task["redmine:byebug:functionals"].invoke
      Rake::Task["redmine:byebug:integration"].invoke
      Rake::Task["redmine:byebug:routing"].invoke
    end

    desc 'Debug all Redmine unit tests along with all the plugins unit tests.'
    task(:units => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      byebug
      Rails::TestUnit::Runner.rake_run FileList["plugins/*/test/unit/**/*_test.rb"]
    end

    desc 'Debug all Redmine functional tests along with all the plugins functional tests.'
    task(:functionals => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      byebug
      Rails::TestUnit::Runner.rake_run FileList["plugins/*/test/functional/**/*_test.rb"]
    end

    desc 'Debug all Redmine integration tests along with all the plugins integration tests.'
    task(:integration => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      byebug
      Rails::TestUnit::Runner.rake_run FileList["plugins/*/test/integration/**/*_test.rb"]
    end

    desc 'Debug all Redmine routing tests along with all the plugins routing tests.'
    task(:routing) do |t|
      $: << "plugins/redmine_testsuites/test"
      byebug
      Rails::TestUnit::Runner.rake_run FileList["plugins/*/test/integration/routing/*_test.rb"] + FileList["plugins/*/test/integration/api_test/*_routing_test.rb"] + FileList["plugins/*/test/routing/*_test.rb"]
    end
    
    desc 'Debug all Redmine helpers tests along with all the plugins helpers tests.'
    task(:helpers) do |t|
      $: << "plugins/redmine_testsuites/test"
      byebug
      Rails::TestUnit::Runner.rake_run FileList["plugins/*/test/helpers/*_test.rb"]
    end
  end
end
