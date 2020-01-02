require 'redmine/plugin'
require Redmine::Plugin.directory + '/redmine_testsuites/lib/testsuites_tests'

namespace :redmine do
      
  desc 'Runs all Redmine tests along with all the plugins tests.'
  task :test do
    Rake::Task["redmine:test:all"].invoke
  end

  namespace :test do
    desc 'Runs all Redmine tests along with all the plugins tests.'
    task :all do
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.rake_run all_tests
    end

    desc 'Runs all Redmine unit tests along with all the plugins unit tests.'
    task(:units => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.rake_run unit_tests
    end

    desc 'Runs all Redmine functional tests along with all the plugins functional tests.'
    task(:functionals => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.rake_run functional_tests
    end

    desc 'Runs all Redmine integration tests along with all the plugins integration tests.'
    task(:integration => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.rake_run integration_tests
    end

    desc 'Runs all Redmine routing tests along with all the plugins routing tests.'
    task(:routing) do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.rake_run routing_tests
    end
    
    desc 'Runs all Redmine helpers tests along with all the plugins helpers tests.'
    task(:helpers) do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.rake_run helper_tests
    end

  end
  
end

