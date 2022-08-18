require_relative '../testsuites_tests'

namespace :redmine do
      
  desc 'Runs all Redmine tests along with all the plugins tests, excluding system tests.'
  task :test do
    Rake::Task["redmine:test:all"].invoke
  end

  namespace :test do
    desc 'Runs all Redmine tests along with all the plugins tests, excluding system tests.'
    task :all do
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.rake_run TestsuitesTests::all_tests
    end

    desc 'Runs all Redmine unit tests along with all the plugins unit tests.'
    task(:units => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.rake_run TestsuitesTests::unit_tests
    end

    desc 'Runs all Redmine functional tests along with all the plugins functional tests.'
    task(:functionals => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.rake_run TestsuitesTests::functional_tests
    end

    desc 'Runs all Redmine integration tests along with all the plugins integration tests.'
    task(:integration => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.rake_run TestsuitesTests::integration_tests
    end

    desc 'Runs all Redmine routing tests along with all the plugins routing tests.'
    task(:routing) do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.rake_run TestsuitesTests::routing_tests
    end
    
    desc 'Runs all Redmine helpers tests along with all the plugins helpers tests.'
    task(:helpers) do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.rake_run TestsuitesTests::helper_tests
    end

    desc 'Runs all Redmine system tests along with all the plugins system tests.'
    task(:system) do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.rake_run TestsuitesTests::system_tests
    end

  end
  
end

