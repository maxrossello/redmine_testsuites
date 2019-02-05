namespace :test do
  desc 'Runs all Redmine tests along with all the plugins tests.'
  task :plugins do
    Rake::Task["test:plugins:all"].invoke
  end

  namespace :plugins do
    desc 'Runs all Redmine tests along with all the plugins tests.'
    task :all do
      Rake::Task["test:plugins:units"].invoke
      Rake::Task["test:plugins:functionals"].invoke
      Rake::Task["test:plugins:integration"].invoke
      #Rake::Task["test:plugins:ui"].invoke
      Rake::Task["test:plugins:routing"].invoke
    end

    desc 'Runs all Redmine unit tests along with all the plugins unit tests.'
    Rake::TestTask.new :units => "db:test:prepare" do |t|
      t.libs << "test"
      t.verbose = true
      t.warning = false
      t.pattern = "plugins/#{ENV['NAME'] || '*'}/test/unit/**/*_test.rb"
    end

    desc 'Runs all Redmine functional tests along with all the plugins functional tests.'
    Rake::TestTask.new :functionals => "db:test:prepare" do |t|
      t.libs << "test"
      t.verbose = true
      t.warning = false
      t.pattern = "plugins/#{ENV['NAME'] || '*'}/test/functional/**/*_test.rb"
    end

    desc 'Runs all Redmine integration tests along with all the plugins integration tests.'
    Rake::TestTask.new :integration => "db:test:prepare" do |t|
      t.libs << "test"
      t.verbose = true
      t.warning = false
      t.pattern = "plugins/#{ENV['NAME'] || '*'}/test/integration/**/*_test.rb"
    end

    desc 'Runs all Redmine ui tests along with all the plugins ui tests.'
    Rake::TestTask.new :ui => "db:test:prepare" do |t|
      t.libs << "test"
      t.verbose = true
      t.warning = false
      t.pattern = "plugins/#{ENV['NAME'] || '*'}/test/ui/**/*_test_ui.rb"
    end

    desc 'Runs all Redmine routing tests along with all the plugins routing tests.'
    Rake::TestTask.new(:routing) do |t|
      t.libs << "test"
      t.verbose = true
      t.warning = false
      t.test_files = FileList["plugins/#{ENV['NAME'] || '*'}/test/integration/routing/*_test.rb"] + FileList["plugins/#{ENV['NAME'] || '*'}/test/integration/api_test/*_routing_test.rb"] + FileList["plugins/#{ENV['NAME'] || '*'}/test/routing/*_test.rb"]
    end
  end
end

