# Redmine - project management software
# Copyright (C) 2006-  Jean-Philippe Lang
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

require_relative '../testsuites_tests'

namespace :redmine do

  desc 'Runs all Redmine tests along with all the plugins tests, excluding system tests.'
  task :test do
    Rake::Task["redmine:test:all"].invoke
  end

  namespace :test do

    desc 'Measures test coverage'
    task :coverage do
      rm_f "coverage"
      ENV["COVERAGE"] = "1"
      Rake::Task["redmine:test:all"].invoke
    end

    desc 'Runs all Redmine tests along with all the plugins tests, excluding system tests.'
    task :all do
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.run_from_rake 'test', TestsuitesTests::all_tests
    end

    desc 'Runs all Redmine unit tests along with all the plugins unit tests.'
    task(:units => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.run_from_rake 'test', TestsuitesTests::unit_tests
    end

    desc 'Runs all Redmine functional tests along with all the plugins functional tests.'
    task(:functionals => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.run_from_rake 'test', TestsuitesTests::functional_tests
    end

    desc 'Runs all Redmine integration tests along with all the plugins integration tests.'
    task(:integration => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.run_from_rake 'test', TestsuitesTests::integration_tests
    end

    task(:routing) do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.run_from_rake 'test', TestsuitesTests::routing_tests
    end
    Rake::Task['redmine:test:routing'].comment = "Runs all Redmine routing tests along with all the plugins routing tests."

    desc 'Run all Redmine helpers tests along with all the plugins helpers tests.'
    task(:helpers) do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.run_from_rake 'test', TestsuitesTests::helper_tests
    end
    
    desc 'Run all Redmine system tests along with all the plugins system tests.'
    task(:system) do |t|
      $: << "plugins/redmine_testsuites/test"
      Rails::TestUnit::Runner.run_from_rake 'test', TestsuitesTests::system_tests
    end
  end
end

