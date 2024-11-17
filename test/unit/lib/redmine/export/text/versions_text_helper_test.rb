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

<<<<<<<< HEAD:test/unit/lib/redmine/export/text/versions_text_helper_test.rb
require_relative '../../../../../test_helper'
========
class Comment < ApplicationRecord
  include Redmine::SafeAttributes
  belongs_to :commented, :polymorphic => true, :counter_cache => true
  belongs_to :author, :class_name => 'User'
>>>>>>>> 6.0.1:app/models/comment.rb

class VersionsTextHelperTest < ActiveSupport::TestCase
  fixtures :users, :projects, :roles, :members, :member_roles,
           :enabled_modules, :issues, :trackers, :enumerations, :versions

  include Redmine::I18n
  include Redmine::Export::Text::VersionsTextHelper

  def test_version_to_text
    expected = <<~EXPECTED
      # 0.1

      07/01/2006

      Beta

<<<<<<<< HEAD:test/unit/lib/redmine/export/text/versions_text_helper_test.rb
      * Bug #11: Closed issue on a closed version
    EXPECTED
    with_settings date_format: '%m/%d/%Y' do
      assert_equal expected, version_to_text(Version.find(1))
========
  private

  def send_notification
    event = "#{commented.class.name.underscore}_comment_added"
    if Setting.notified_events.include?(event)
      Mailer.public_send(:"deliver_#{event}", self)
>>>>>>>> 6.0.1:app/models/comment.rb
    end
  end
end
