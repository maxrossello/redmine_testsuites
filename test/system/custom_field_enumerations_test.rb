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

<<<<<<<< HEAD:test/system/custom_field_enumerations_test.rb
require_relative '../application_system_test_case'

class CustomFieldEnumerationsTest < ApplicationSystemTestCase
  fixtures :projects, :users, :email_addresses, :roles, :members, :member_roles,
           :trackers, :projects_trackers, :enabled_modules, :issue_statuses, :issues,
           :enumerations, :custom_fields, :custom_values, :custom_fields_trackers,
           :watchers, :journals, :journal_details

  def test_add_empty_value
    custom_field = IssueCustomField.generate!(field_format: 'enumeration')
    log_user('admin', 'admin')
    visit "custom_fields/#{custom_field.id}/enumerations"

    click_on 'Add'
    assert page.has_css?('#errorExplanation', text: 'Name cannot be blank')
========
class MailHandlerController < ActionController::Base
  include ActiveSupport::SecurityUtils

  before_action :check_credential

  # Requests from rdm-mailhandler.rb don't contain CSRF tokens
  skip_before_action :verify_authenticity_token

  # Displays the email submission form
  def new
  end

  # Submits an incoming email to MailHandler
  def index
    # MailHandlerController#index should permit all options set by
    # RedmineMailHandler#submit in rdm-mailhandler.rb.
    # It must be kept in sync.
    options = params.permit(
      :key,
      :email,
      :allow_override,
      :unknown_user,
      :default_group,
      :no_account_notice,
      :no_notification,
      :no_permission_check,
      :project_from_subaddress,
      {
        issue: [
          :project,
          :status,
          :tracker,
          :category,
          :priority,
          :assigned_to,
          :fixed_version,
          :is_private
        ]
      }
    ).to_h
    email = options.delete(:email)
    if MailHandler.safe_receive(email, options)
      head :created
    else
      head :unprocessable_content
    end
  end

  private

  def check_credential
    User.current = nil
    unless Setting.mail_handler_api_enabled? && secure_compare(params[:key].to_s, Setting.mail_handler_api_key.to_s)
      render :plain => 'Access denied. Incoming emails WS is disabled or key is invalid.', :status => :forbidden
    end
>>>>>>>> 6.0.1:app/controllers/mail_handler_controller.rb
  end
end
