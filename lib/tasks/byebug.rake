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
      Rails::TestUnit::Runner.run_from_rake 'test', TestsuitesTests::all_tests
    end

    desc 'Debug all Redmine unit tests along with all the plugins unit tests.'
    task(:units => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      byebug
      Rails::TestUnit::Runner.run_from_rake 'test', TestsuitesTests::unit_tests
    end

    desc 'Debug all Redmine functional tests along with all the plugins functional tests.'
    task(:functionals => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      byebug
      Rails::TestUnit::Runner.run_from_rake 'test', TestsuitesTests::functional_tests
    end

    desc 'Debug all Redmine integration tests along with all the plugins integration tests.'
    task(:integration => "db:test:prepare") do |t|
      $: << "plugins/redmine_testsuites/test"
      byebug
      Rails::TestUnit::Runner.run_from_rake 'test', TestsuitesTests::integration_tests
    end

    task(:routing) do |t|
      $: << "plugins/redmine_testsuites/test"
      byebug
      Rails::TestUnit::Runner.run_from_rake 'test', TestsuitesTests::routing_tests
    end
    Rake::Task['redmine:byebug:routing'].comment = "Runs all Redmine routing tests along with all the plugins routing tests."
    
    desc 'Debug all Redmine helpers tests along with all the plugins helpers tests.'
    task(:helpers) do |t|
      $: << "plugins/redmine_testsuites/test"
      byebug
      Rails::TestUnit::Runner.run_from_rake 'test', TestsuitesTests::helper_tests
    end
    
    desc 'Debug all Redmine system tests along with all the plugins system tests.'
    task(:system) do |t|
      $: << "plugins/redmine_testsuites/test"
      byebug
      Rails::TestUnit::Runner.run_from_rake 'test', TestsuitesTests::system_tests
    end
  end
end
