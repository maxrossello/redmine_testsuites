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
<<<<<<<< HEAD:test/unit/lib/redmine/search_test.rb
=======
>>>>>>> 6.0.1
require_relative '../../../test_helper'

class Redmine::Search::Tokenize < ActiveSupport::TestCase
  def test_tokenize
    value = "hello \"bye bye\""
    assert_equal ["hello", "bye bye"], Redmine::Search::Tokenizer.new(value).tokens
<<<<<<< HEAD
========
class Change < ApplicationRecord
  belongs_to :changeset

  validates_presence_of :changeset_id, :action, :path
  before_validation :replace_invalid_utf8_of_path
  before_save :init_path

  def replace_invalid_utf8_of_path
    self.path      = Redmine::CodesetUtil.replace_invalid_utf8(self.path)
    self.from_path = Redmine::CodesetUtil.replace_invalid_utf8(self.from_path)
>>>>>>>> 6.0.1:app/models/change.rb
=======
>>>>>>> 6.0.1
  end

  def test_tokenize_should_consider_ideographic_space_as_separator
    # U+3000 is an ideographic space ("　")
    value = "全角\u3000スペース"
    assert_equal %w[全角 スペース], Redmine::Search::Tokenizer.new(value).tokens
  end
<<<<<<< HEAD
=======

  def test_tokenize_should_support_multiple_phrases
    value = '"phrase one" "phrase two"'
    assert_equal ["phrase one", "phrase two"], Redmine::Search::Tokenizer.new(value).tokens
  end
>>>>>>> 6.0.1
end
