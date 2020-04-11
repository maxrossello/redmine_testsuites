require 'minitest/bisect'
require 'redmine/plugin'
require Redmine::Plugin.directory + '/redmine_testsuites/lib/testsuites_tests'

namespace :redmine do
  
  desc 'Bisects all Redmine tests along with all the plugins tests.'
  task :bisect do
    Rake::Task["redmine:bisect:all"].invoke
  end

  namespace :bisect do
    desc 'Bisects all Redmine tests along with all the plugins tests.'
    ENV['MTB_VERBOSE']="2"
    task :all do
      $: << "plugins/redmine_testsuites/test"
      Minitest::Bisect.run ["-Iplugins/redmine_testsuites/test"] + all_tests + (ENV['TESTOPTS'] || "").split(" ")
    end

    desc 'Bisects all Redmine unit tests along with all the plugins unit tests.'
    task(:units => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      Minitest::Bisect.run ["-Iplugins/redmine_testsuites/test"] + unit_tests + (ENV['TESTOPTS'] || "").split(" ")
    end

    desc 'Bisects all Redmine functional tests along with all the plugins functional tests.'
    task(:functionals => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      Minitest::Bisect.run ["-Iplugins/redmine_testsuites/test"]+ functional_tests + (ENV['TESTOPTS'] || "").split(" ")
    end

    desc 'Bisects all Redmine integration tests along with all the plugins integration tests.'
    task(:integration => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      Minitest::Bisect.run ["-Iplugins/redmine_testsuites/test"] + integration_tests + (ENV['TESTOPTS'] || "").split(" ")
    end

    desc 'Bisects all Redmine routing tests along with all the plugins routing tests.'
    task(:routing) do |t|
      $: << "plugins/redmine_testsuites/test"
      Minitest::Bisect.run ["-Iplugins/redmine_testsuites/test"] + routing_tests + (ENV['TESTOPTS'] || "").split(" ")
    end
    
    desc 'Bisects all Redmine helpers tests along with all the plugins helpers tests.'
    task(:helpers) do |t|
      $: << "plugins/redmine_testsuites/test"
      Minitest::Bisect.run ["-Iplugins/redmine_testsuites/test"] + helper_tests + (ENV['TESTOPTS'] || "").split(" ")
    end
  end
end
