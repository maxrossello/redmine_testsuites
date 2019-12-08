require 'minitest/bisect'

namespace :redmine do
  
  desc 'Bisects all Redmine tests along with all the plugins tests.'
  task :bisect do
    Rake::Task["redmine:bisect:all"].invoke
  end

  namespace :bisect do
    desc 'Bisects all Redmine tests along with all the plugins tests.'
    ENV['MTB_VERBOSE']="2"
    task :all do
      Rake::Task["redmine:bisect:units"].invoke
      Rake::Task["redmine:bisect:functionals"].invoke
      Rake::Task["redmine:bisect:integration"].invoke
      Rake::Task["redmine:bisect:routing"].invoke
      Rake::Task["redmine:bisect:helpers"].invoke
    end

    desc 'Bisects all Redmine unit tests along with all the plugins unit tests.'
    task(:units => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      Minitest::Bisect.run ["-Iplugins/redmine_testsuites/test"]+FileList["plugins/*/test/unit/**/*_test.rb"] + ENV['TESTOPTS'].split(" ")
    end

    desc 'Bisects all Redmine functional tests along with all the plugins functional tests.'
    task(:functionals => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      Minitest::Bisect.run ["-Iplugins/redmine_testsuites/test"]+FileList["plugins/*/test/functional/**/*_test.rb"] + ENV['TESTOPTS'].split(" ")
    end

    desc 'Bisects all Redmine integration tests along with all the plugins integration tests.'
    task(:integration => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      Minitest::Bisect.run ["-Iplugins/redmine_testsuites/test"]+FileList["plugins/*/test/integration/**/*_test.rb"] + ENV['TESTOPTS'].split(" ")
    end

    desc 'Bisects all Redmine routing tests along with all the plugins routing tests.'
    task(:routing) do |t|
      $: << "plugins/redmine_testsuites/test"
      Minitest::Bisect.run ["-Iplugins/redmine_testsuites/test"]+FileList["plugins/*/test/integration/routing/*_test.rb"] + FileList["plugins/*/test/integration/api_test/*_routing_test.rb"] + FileList["plugins/*/test/routing/*_test.rb"] + ENV['TESTOPTS'].split(" ")
    end
    
    desc 'Bisects all Redmine helpers tests along with all the plugins helpers tests.'
    task(:helpers) do |t|
      $: << "plugins/redmine_testsuites/test"
      Minitest::Bisect.run ["-Iplugins/redmine_testsuites/test"]+FileList["plugins/*/test/helpers/*_test.rb"]
    end
  end
end
