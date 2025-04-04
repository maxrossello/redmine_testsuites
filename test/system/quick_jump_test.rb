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

class QuickJumpTest < ApplicationSystemTestCase
  def test_project_quick_jump
    log_user 'jsmith', 'jsmith'
    visit '/'

    within '#header' do
      #page.first('span', :text => 'Jump to a project...').click
      page.first('span', :text => I18n.t(:label_jump_to_a_project)).click
      click_link('eCookbook', match: :first)
    end
    assert_current_path '/projects/ecookbook?jump=welcome'
  end

  def test_project_quick_jump_should_jump_to_the_same_tab
    log_user 'jsmith', 'jsmith'
    visit '/issues'

    within '#header' do
      #page.first('span', :text => 'Jump to a project...').click
      page.first('span', :text => I18n.t(:label_jump_to_a_project)).click
      click_link('eCookbook', match: :first)
      assert_current_path '/projects/ecookbook/issues'

      page.first('span', :text => 'eCookbook').click
      #click_on 'All Projects'
      click_on I18n.t(:label_project_all)
      assert_current_path '/issues'
    end
  end

  def test_project_quick_search
    Project.generate!(:name => 'Megaproject', :identifier => 'mega')

    log_user 'jsmith', 'jsmith'
    visit '/'

    within '#header' do
      #page.first('span', :text => 'Jump to a project...').click
      page.first('span', :text => I18n.t(:label_jump_to_a_project)).click
      # Fill the quick search input that should have focus
      page.first('*:focus').set('meg')
      click_on 'Megaproject'
    end
    assert_current_path '/projects/mega?jump=welcome'
  end
end
