
namespace :redmine do
      
  desc 'Runs all Redmine tests along with all the plugins tests.'
  task :test do
    Rake::Task["redmine:test:all"].invoke
  end

  namespace :test do
    desc 'Runs all Redmine tests along with all the plugins tests.'
    task :all do
      Rake::Task["redmine:test:units"].invoke
      Rake::Task["redmine:test:functionals"].invoke
      Rake::Task["redmine:test:integration"].invoke
      Rake::Task["redmine:test:routing"].invoke
      Rake::Task["redmine:test:helpers"].invoke
    end

    desc 'Runs all Redmine unit tests along with all the plugins unit tests.'
    task(:units => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.rake_run FileList["plugins/*/test/unit/**/*_test.rb"]
    end

    desc 'Runs all Redmine functional tests along with all the plugins functional tests.'
    task(:functionals => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.rake_run FileList["plugins/*/test/functional/**/*_test.rb"]
    end

    desc 'Runs all Redmine integration tests along with all the plugins integration tests.'
    task(:integration => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.rake_run FileList["plugins/*/test/integration/**/*_test.rb"]
    end

    desc 'Runs all Redmine routing tests along with all the plugins routing tests.'
    task(:routing) do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.rake_run FileList["plugins/*/test/integration/routing/*_test.rb"] + FileList["plugins/*/test/integration/api_test/*_routing_test.rb"] + FileList["plugins/*/test/routing/*_test.rb"]
    end
    
    desc 'Runs all Redmine helpers tests along with all the plugins helpers tests.'
    task(:helpers) do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.rake_run FileList["plugins/*/test/helpers/*_test.rb"]
    end

  end
  
end

