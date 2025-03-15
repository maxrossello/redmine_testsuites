# frozen_string_literal: true

# Redmine - project management software
<<<<<<<< HEAD:test/functional/application_controller_test.rb
# Copyright (C) 2006-2023  Jean-Philippe Lang
========
# Copyright (C) 2006-  Jean-Philippe Lang
>>>>>>>> 5.1.7:app/controllers/welcome_controller.rb
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

require_relative '../test_helper'

<<<<<<<< HEAD:test/functional/application_controller_test.rb
class ApplicationControllerTest < Redmine::ControllerTest
  def test_back_url_should_remove_utf8_checkmark_from_referer
    @request.set_header 'HTTP_REFERER', "/path?utf8=\u2713&foo=bar"
    assert_equal "/path?foo=bar", @controller.back_url
========
  skip_before_action :check_if_login_required, only: [:robots]

  def index
    @news = News.latest User.current
  end

  def robots
    @projects = Project.visible(User.anonymous) unless Setting.login_required?
    render :layout => false, :content_type => 'text/plain'
>>>>>>>> 5.1.7:app/controllers/welcome_controller.rb
  end
end
