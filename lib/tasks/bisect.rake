require 'minitest/bisect'
require_relative '../testsuites_tests'

namespace :redmine do
  
  desc 'Bisects all Redmine tests along with all the plugins tests, excluding system tests.'
  task :bisect do
    Rake::Task["redmine:bisect:all"].invoke
  end

  namespace :bisect do
    desc 'Bisects all Redmine tests along with all the plugins tests, excluding system tests.'
    ENV['MTB_VERBOSE']="2"
    task :all do
      $: << "plugins/redmine_testsuites/test"
      Minitest::Bisect.run ["-Iplugins/redmine_testsuites/test"] + TestsuitesTests::all_tests + (ENV['TESTOPTS'] || "").split(" ")
    end

    desc 'Bisects all Redmine unit tests along with all the plugins unit tests.'
    task(:units => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      Minitest::Bisect.run ["-Iplugins/redmine_testsuites/test"] + TestsuitesTests::unit_tests + (ENV['TESTOPTS'] || "").split(" ")
    end

    desc 'Bisects all Redmine functional tests along with all the plugins functional tests.'
    task(:functionals => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      Minitest::Bisect.run ["-Iplugins/redmine_testsuites/test"]+ TestsuitesTests::functional_tests + (ENV['TESTOPTS'] || "").split(" ")
    end

    desc 'Bisects all Redmine integration tests along with all the plugins integration tests.'
    task(:integration => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      Minitest::Bisect.run ["-Iplugins/redmine_testsuites/test"] + TestsuitesTests::integration_tests + (ENV['TESTOPTS'] || "").split(" ")
    end

    desc 'Bisects all Redmine routing tests along with all the plugins routing tests.'
    task(:routing) do |t|
      $: << "plugins/redmine_testsuites/test"
      Minitest::Bisect.run ["-Iplugins/redmine_testsuites/test"] + TestsuitesTests::routing_tests + (ENV['TESTOPTS'] || "").split(" ")
    end
    
    desc 'Bisects all Redmine helpers tests along with all the plugins helpers tests.'
    task(:helpers) do |t|
      $: << "plugins/redmine_testsuites/test"
      Minitest::Bisect.run ["-Iplugins/redmine_testsuites/test"] + TestsuitesTests::helper_tests + (ENV['TESTOPTS'] || "").split(" ")
    end

    desc 'Bisects all Redmine system tests along with all the plugins system tests.'
    task(:system) do |t|
      $: << "plugins/redmine_testsuites/test"
      Minitest::Bisect.run ["-Iplugins/redmine_testsuites/test"] + TestsuitesTests::system_tests + (ENV['TESTOPTS'] || "").split(" ")
    end

  end
end
