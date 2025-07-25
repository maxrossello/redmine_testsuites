# frozen_string_literal: true

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

require_relative '../application_system_test_case'

Capybara.default_max_wait_time = 2

class TimelogTest < ApplicationSystemTestCase
  def test_changing_project_should_update_activities
    project = Project.find(1)
    TimeEntryActivity.create!(:name => 'Design', :project => project, :parent => TimeEntryActivity.find_by_name('Design'), :active => false)

    log_user 'jsmith', 'jsmith'
    visit '/time_entries/new'
    within 'select#time_entry_activity_id' do
      assert has_content?('Development')
      assert has_content?('Design')
    end

    within 'form#new_time_entry' do
      #select 'eCookbook', :from => 'Project'
      select 'eCookbook', :from => I18n.t(:field_project)
    end
    within 'select#time_entry_activity_id' do
      assert has_content?('Development')
      assert has_no_content?('Design')
    end
  end

  def test_bulk_edit
    log_user 'jsmith', 'jsmith'
    visit '/time_entries/bulk_edit?ids[]=1&ids[]=2&ids[]=3'
    fill_in 'Hours', :with => '8.5'
    select 'QA', :from => 'Activity'
    page.first(:button, 'Submit').click
    wait_for_ajax # redmine_testsuites

    assert_text 'Successful update.'

    entries = TimeEntry.where(:id => [1, 2, 3]).to_a
    assert entries.all? {|entry| entry.hours == 8.5}
    assert entries.all? {|entry| entry.activity.name == 'QA'}
  end

  def test_bulk_edit_with_failure
    log_user 'jsmith', 'jsmith'
    visit '/time_entries/bulk_edit?ids[]=1&ids[]=2&ids[]=3'
    fill_in 'Hours', :with => 'A'
    page.first(:button, 'Submit').click

    assert page.has_css?('#errorExplanation')
    fill_in 'Hours', :with => ''  # redmine_testsuites
    fill_in 'Hours', :with => '7'
    page.first(:button, 'Submit').click

    assert_current_path "/projects/ecookbook/time_entries"
    entries = TimeEntry.where(:id => [1, 2, 3]).to_a
    assert entries.all? {|entry| entry.hours == 7.0}
  end

  def test_default_query_setting
    with_settings :default_language => 'en', :force_default_language_for_anonymous => '1' do
      # Display the list with the default settings
      visit '/time_entries'
      within 'table.time-entries thead' do
        assert page.has_no_link?('Tracker')
        assert page.has_text?('Comment')
      end
    end

    # Change the default columns
    log_user 'admin', 'admin'
    visit '/settings?tab=timelog'
    # Remove a column
    select 'Comment', :from => 'Selected Columns'
    page.first('input[type=button].move-left').click
    # Add a column
    #select 'Tracker', :from => 'Available Columns'
    select I18n.t(:field_tracker), :from => I18n.t(:description_available_columns)
    page.first('input[type=button].move-right').click
    click_on 'Save'
    assert_text 'Successful update.'

    # Display the list with updated settings
    visit '/time_entries'
    within 'table.time-entries thead' do
      #assert page.has_link?('Tracker')
      assert page.has_link?(I18n.t(:field_tracker))
      assert page.has_no_text?('Comment')
    end
  end
end
