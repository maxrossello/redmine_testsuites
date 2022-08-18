require 'byebug'
require 'byebug/breakpoint'
require_relative '../testsuites_tests'

namespace :redmine do
  
  desc 'Debug all Redmine tests along with all the plugins tests, excluding system tests.'
  task :byebug do
    Rake::Task["redmine:byebug:all"].invoke
  end

  namespace :byebug do
    desc 'Debug all Redmine tests along with all the plugins tests, excluding system tests.'
    task :all do
      $: << "plugins/redmine_testsuites/test"
      byebug
      Rails::TestUnit::Runner.rake_run TestsuitesTests::all_tests
    end

    desc 'Debug all Redmine unit tests along with all the plugins unit tests.'
    task(:units => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      byebug
      Rails::TestUnit::Runner.rake_run TestsuitesTests::unit_tests
    end

    desc 'Debug all Redmine functional tests along with all the plugins functional tests.'
    task(:functionals => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      byebug
      Rails::TestUnit::Runner.rake_run TestsuitesTests::functional_tests
    end

    desc 'Debug all Redmine integration tests along with all the plugins integration tests.'
    task(:integration => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      byebug
      Rails::TestUnit::Runner.rake_run TestsuitesTests::integration_tests
    end

    desc 'Debug all Redmine routing tests along with all the plugins routing tests.'
    task(:routing) do |t|
      $: << "plugins/redmine_testsuites/test"
      byebug
      Rails::TestUnit::Runner.rake_run TestsuitesTests::routing_tests
    end
    
    desc 'Debug all Redmine helpers tests along with all the plugins helpers tests.'
    task(:helpers) do |t|
      $: << "plugins/redmine_testsuites/test"
      byebug
      Rails::TestUnit::Runner.rake_run TestsuitesTests::helper_tests
    end
    
    desc 'Debug all Redmine system tests along with all the plugins system tests.'
    task(:system) do |t|
      $: << "plugins/redmine_testsuites/test"
      byebug
      Rails::TestUnit::Runner.rake_run TestsuitesTests::system_tests
    end

  end
end
