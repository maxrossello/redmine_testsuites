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

    task(:routing) do |t|
      $: << "plugins/redmine_testsuites/test"
      Minitest::Bisect.run ["-Iplugins/redmine_testsuites/test"] + TestsuitesTests::routing_tests + (ENV['TESTOPTS'] || "").split(" ")
    end
    Rake::Task['redmine:bisect:routing'].comment = "Bisects all Redmine routing tests along with all the plugins routing tests."    
    
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
