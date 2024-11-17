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

<<<<<<< HEAD
require_relative '../../../test_helper'

class Redmine::PluginLoaderTest < ActiveSupport::TestCase
=======
<<<<<<<< HEAD:test/unit/lib/redmine/wiki_formatting/markdown_html_parser_test.rb
require_relative '../../../../test_helper'

class Redmine::WikiFormatting::MarkdownHtmlParserTest < ActiveSupport::TestCase
========
require_relative '../../../test_helper'

class Redmine::PluginLoaderTest < ActiveSupport::TestCase
>>>>>>>> 6.0.1:test/unit/lib/redmine/plugin_loader_test.rb
>>>>>>> 6.0.1
  def setup
    clear_public

    @klass = Redmine::PluginLoader
    @klass.directory = Rails.root.join('test/fixtures/plugins')
<<<<<<< HEAD
    @klass.public_directory = Rails.root.join('tmp/public/plugin_assets')
    @klass.load
  end

=======
    @klass.load
  end

<<<<<<<< HEAD:test/unit/lib/redmine/wiki_formatting/markdown_html_parser_test.rb
  def test_should_convert_tags
    assert_equal(
      'A **simple** html snippet.',
      @parser.to_text('<p>A <b>simple</b> html snippet.</p>')
    )
    assert_equal(
      'foo [bar](http://example.com/) baz',
      @parser.to_text('foo<a href="http://example.com/">bar</a>baz')
    )
    assert_equal(
      'foo http://example.com/ baz',
      @parser.to_text('foo<a href="http://example.com/"></a>baz')
    )
    assert_equal(
      'foobarbaz',
      @parser.to_text('foo<a name="Header-one">bar</a>baz')
    )
    assert_equal(
      'foobaz',
      @parser.to_text('foo<a name="Header-one"/>baz')
    )
  end

  def test_html_tables_conversion
    assert_equal(
      "*th1*\n*th2*\n\ntd1\ntd2",
      @parser.to_text('<table><tr><th>th1</th><th>th2</th></tr><tr><td>td1</td><td>td2</td></tr></table>')
    )
========
>>>>>>> 6.0.1
  def teardown
    clear_public
  end

<<<<<<< HEAD
  def test_create_assets_reloader
    plugin_assets = @klass.create_assets_reloader
    plugin_assets.execute.inspect

    assert File.exist?("#{@klass.public_directory}/foo_plugin")
    assert File.exist?("#{@klass.public_directory}/foo_plugin/stylesheets/foo.css")
  end

  def test_mirror_assets
    Redmine::PluginLoader.mirror_assets

    assert File.exist?("#{@klass.public_directory}/foo_plugin")
    assert File.exist?("#{@klass.public_directory}/foo_plugin/stylesheets/foo.css")
  end

  def test_mirror_assets_with_plugin_name
    Redmine::PluginLoader.mirror_assets('foo_plugin')

    assert File.exist?("#{@klass.public_directory}/foo_plugin")
    assert File.exist?("#{@klass.public_directory}/foo_plugin/stylesheets/foo.css")
  end

  def clear_public
    FileUtils.rm_rf 'tmp/public'
=======
  def clear_public
    FileUtils.rm_rf 'tmp/public'
>>>>>>>> 6.0.1:test/unit/lib/redmine/plugin_loader_test.rb
>>>>>>> 6.0.1
  end
end
