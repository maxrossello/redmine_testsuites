# Redmine plugin for Better Overviews
# Copyright (C) 2018    Massimo Rossello 
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require 'redmine'

Rails.logger.info 'Redmine Test Suites'

if ENV["RAILS_ENV"] == "test"
  Redmine::Plugin.register :redmine_testsuites do
    name 'Redmine Test Suites plugin'
    author 'Massimo Rossello'
    description 'Allows to run the Redmine test suite along with plugin tests, considering the different behaviors introduced by supported plugins over the Redmine default behavior.'
    version '3.4.10'
    url 'https://github.com/maxrossello/redmine_testsuites.git'
    author_url 'https://github.com/maxrossello'
    requires_redmine :version => '3.4.10'
  end 

  #Rails.application.config.active_support.test_order = :sorted
  
  # each hash contains conditions in AND; plugin is supported if any hash in array matches 
  supported_plugins = {
    redmine_testsuites:        {},
    redmine_translation_terms: [{ version_or_higher: '3.4.8' }]
  }
  
  require_dependency 'testsuites_versions'
  
  Rails.configuration.to_prepare do
    Testsuites::Versions.check_plugin_versions(supported_plugins);
  end
end


