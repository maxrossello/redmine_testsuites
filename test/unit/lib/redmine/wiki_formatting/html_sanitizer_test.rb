# frozen_string_literal: true

# Redmine - project management software
# Copyright (C) 2006-2023  Jean-Philippe Lang
#
# FileSystem adapter
# File written by Paul Rivier, at Demotera.
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

require_relative '../../../../test_helper'

class Redmine::WikiFormatting::HtmlSanitizerTest < ActiveSupport::TestCase
  def setup
    @sanitizer = Redmine::WikiFormatting::HtmlSanitizer
  end

  def test_should_allow_links_with_safe_url_schemes_and_append_external_class
    %w(http https ftp ssh foo).each do |scheme|
      input = %(<a href="#{scheme}://example.org/">foo</a>)
      assert_equal %(<a href="#{scheme}://example.org/" class="external">foo</a>), @sanitizer.call(input)
    end
  end

  def self.scm_adapter_class
    Redmine::Scm::Adapters::FilesystemAdapter
  end

  def self.scm_name
    'Filesystem'
  end

  def supports_history?
    false
  end

  def fetch_changesets
    nil
  end
end
