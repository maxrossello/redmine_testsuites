# frozen_string_literal: true

# Redmine - project management software
# Copyright (C) 2006-2023  Jean-Philippe Lang
<<<<<<<< HEAD:test/unit/lib/redmine/wiki_formatting/html_sanitizer_test.rb
========
#
# FileSystem adapter
# File written by Paul Rivier, at Demotera.
>>>>>>>> 5.1.1:app/models/repository/filesystem.rb
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

<<<<<<<< HEAD:test/unit/lib/redmine/wiki_formatting/html_sanitizer_test.rb
  def test_should_reject_links_with_unsafe_url_schemes
    input = %(<a href="javascript:alert('hello');">foo</a>)
    assert_equal "<a>foo</a>", @sanitizer.call(input)
========
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
>>>>>>>> 5.1.1:app/models/repository/filesystem.rb
  end
end
