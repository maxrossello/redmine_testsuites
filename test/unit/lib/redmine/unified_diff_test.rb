# frozen_string_literal: true

# Copyright (C) 2006-2021  Jean-Philippe Lang
    raw = <<~DIFF
      --- test.orig.txt Wed Feb 15 16:10:39 2012
      +++ test.new.txt  Wed Feb 15 16:11:25 2012
      @@ -1,5 +1,5 @@
       Semicolons were mysteriously appearing in code diffs in the repository
        
      -void DoSomething(std::auto_ptr<MyClass> myObj)
      +void DoSomething(const MyClass& myObj)
       
    DIFF
    diff = Redmine::UnifiedDiff.new(<<~DIFF)
      --- old.txt Wed Nov 11 14:24:58 2009
      +++ new.txt Wed Nov 11 14:25:02 2009
      @@ -1,8 +1,4 @@
      -Lines that starts with dashes:
      -
      -------------------------
      --- file.c
      -------------------------
      +A line that starts with dashes:

       and removed.

      @@ -23,4 +19,4 @@



      -Another chunk of change
      +Another chunk of changes

    DIFF
    diff = Redmine::UnifiedDiff.new(<<~DIFF)
      diff -r 000000000000 -r ea98b14f75f0 README1
      --- /dev/null
      +++ b/README1
      @@ -0,0 +1,1 @@
      +test1
      diff -r 000000000000 -r ea98b14f75f0 README2
      --- /dev/null
      +++ b/README2
      @@ -0,0 +1,1 @@
      +test2
      diff -r 000000000000 -r ea98b14f75f0 README3
      --- /dev/null
      +++ b/README3
      @@ -0,0 +1,3 @@
      +test4
      +test5
      +test6
      diff -r 000000000000 -r ea98b14f75f0 README4
      --- /dev/null
      +++ b/README4
      @@ -0,0 +1,3 @@
      +test4
      +test5
      +test6
    DIFF
    diff = Redmine::UnifiedDiff.new(<<~DIFF)
      # HG changeset patch
      # User test
      # Date 1348014182 -32400
      # Node ID d1c871b8ef113df7f1c56d41e6e3bfbaff976e1f
      # Parent  180b6605936cdc7909c5f08b59746ec1a7c99b3e
      modify test1.txt

      diff -r 180b6605936c -r d1c871b8ef11 test1.txt
      --- a/test1.txt
      +++ b/test1.txt
      @@ -1,1 +1,1 @@
      -test1
      +modify test1
    DIFF
    diff = Redmine::UnifiedDiff.new(<<~DIFF)
      From 585da9683fb5ed7bf7cb438492e3347cdf3d83df Mon Sep 17 00:00:00 2001
      From: Gregor Schmidt <schmidt@nach-vorne.eu>
      Date: Mon, 5 Mar 2018 14:12:13 +0100
      Subject: [PATCH] changes including a rename, rename+modify and addition

      ---
       one.markdown => one.md | 0
       three.md               | 2 ++
       two.markdown => two.md | 1 +
       3 files changed, 3 insertions(+)
       rename one.markdown => one.md (100%)
       create mode 100644 three.md
       rename two.markdown => two.md (50%)

      diff --git a/one.markdown b/one.md
      similarity index 100%
      rename from one.markdown
      rename to one.md
      diff --git a/three.md b/three.md
      new file mode 100644
      index 0000000..288012f
      --- /dev/null
      +++ b/three.md
      @@ -0,0 +1,2 @@
      +three
      +=====
      diff --git a/two.markdown b/two.md
      similarity index 50%
      rename from two.markdown
      rename to two.md
      index f719efd..6a268ed 100644
      --- a/two.markdown
      +++ b/two.md
      @@ -1 +1,2 @@
       two
      +===
      --
      2.14.1
    DIFF
    diff = Redmine::UnifiedDiff.new(<<~DIFF)
      --- test1.txt
      +++ b/test02.txt
      @@ -1 +0,0 @@
      -modify test1
    DIFF
    diff = Redmine::UnifiedDiff.new(<<~DIFF)
      --- a/test1.txt
      +++ a/test02.txt
      @@ -1 +0,0 @@
      -modify test1
    DIFF
    diff = Redmine::UnifiedDiff.new(<<~DIFF)
      --- a/test1.txt
      +++ test02.txt
      @@ -1 +0,0 @@
      -modify test1
    DIFF
      assert_equal '  text_tip_issue_end_day: この日に終了する<span>タスク</span>', diff.first[4].html_line_left
      assert_equal '        other: &quot;около %{count} час<span>а</span>&quot;', diff.first[3].html_line_left
    raw = <<~DIFF
      --- a.txt	2013-04-05 14:19:39.000000000 +0900
      +++ b.txt	2013-04-05 14:19:51.000000000 +0900
      @@ -1,3 +1,3 @@
       aaaa
      -abc
      +abcd
       bbbb
    DIFF
    raw = <<~DIFF
      --- a.txt	2013-04-05 14:19:39.000000000 +0900
      +++ b.txt	2013-04-05 14:19:51.000000000 +0900
      @@ -1,3 +1,3 @@
       aaaa
      -abc
      +zabc
       bbbb
    DIFF
      diff =
        Redmine::UnifiedDiff.new(
          read_diff_fixture('issue-13644-1.diff'), :type => 'sbs'
        )
      assert_equal '日本<span></span>', diff.first[1].html_line_left
      assert_equal '日本<span>語</span>', diff.first[1].html_line_right
      diff =
        Redmine::UnifiedDiff.new(
          read_diff_fixture('issue-13644-2.diff'), :type => 'sbs'
        )
      assert_equal '<span></span>日本', diff.first[1].html_line_left
      assert_equal '<span>にっぽん</span>日本', diff.first[1].html_line_right
      diff =
        Redmine::UnifiedDiff.new(
          read_diff_fixture('issue-13644-3.diff'), :type => 'sbs'
        )
      assert_equal '日本<span>記</span>', diff.first[1].html_line_left
      assert_equal '日本<span>娘</span>', diff.first[1].html_line_right
    # UTF-8 The 2nd byte differs.
      diff =
        Redmine::UnifiedDiff.new(
          read_diff_fixture('issue-13644-4.diff'), :type => 'sbs'
        )
      assert_equal '日本<span>記</span>', diff.first[1].html_line_left
      assert_equal '日本<span>誘</span>', diff.first[1].html_line_right
    # UTF-8 The 2nd byte differs.
      diff =
        Redmine::UnifiedDiff.new(
          read_diff_fixture('issue-13644-5.diff'), :type => 'sbs'
        )
      assert_equal '日本<span>記</span>ok', diff.first[1].html_line_left
      assert_equal '日本<span>誘</span>ok', diff.first[1].html_line_right
  def test_keep_similar_git_footer_line
    raw = <<~DIFF
      diff --git a/test1.txt b/test1.txt
      --- a/test1.txt
      +++ b/test1.txt
      @@ -1,11 +1,6 @@
       $ git init --bare git_utf8_repository
       $ hg init git_utf8_repository_hg
       $ cd git_utf8_repository_hg
      --
      -Next line has white space after '-'
      -- 
      ---
      --
       $ touch test.txt
       $ hg add test.txt
       $ hg commit -m `echo -e "U+1F603\U1F603"` -u `echo -e "U+1F603\U1F603"`
      diff --git a/test2.txt b/test2.txt
      --- a/test2.txt
      +++ b/test2.txt
      @@ -5,9 +5,4 @@
       $ hg add test.txt
       $ hg commit -m `echo -e "U+1F603\U1F603"` -u `echo -e "U+1F603\U1F603"`
       $ hg bookmark master
      --
      -Next line has white space after '-'
      -- 
      ---
      --
       $ hg push ../git_utf8_repository
    DIFF
    lines = raw.split("\n")
    assert_equal '-- ', lines[9]
    assert_equal '-- ', lines[24]
    diff = Redmine::UnifiedDiff.new(raw, :type => 'sbs')
    assert_equal 2, diff.size
    assert_equal 11, diff[0].size
    assert_equal 9, diff[1].size
  end

  def test_git_footer_line
    raw = <<~DIFF
      From 1ed13eda266a3e0a5a8624e79ae28874ebcdeb5c Mon Sep 17 00:00:00 2001
      From: test <none@none>
      Date: Thu, 30 Apr 2020 11:40:20 +0900
      Subject: [PATCH] add 'rpm -q git' and its result
      
      ---
       test.txt | 2 ++
       1 file changed, 2 insertions(+)

      diff --git a/test.txt b/test.txt
      index 0a406b9..c39ee31 100644
      --- a/test.txt
      +++ b/test.txt
      @@ -6,3 +6,5 @@ $ hg add test.txt
       $ hg commit -m `echo -e "U+1F603\U1F603"` -u `echo -e "U+1F603\U1F603"`
       $ hg bookmark master
       $ hg push ../git_utf8_repository
      +$ rpm -q git
      +git-1.8.3.1-21.el7_7.x86_64
      -- 
      1.8.3.1
      
    DIFF
    lines = raw.split("\n")
    lines << ""
    assert_equal '', lines[-1]
    body_lines = lines[0..-4]
    footer_lines = lines[-3..-1]
    assert_equal '+git-1.8.3.1-21.el7_7.x86_64', body_lines[-1]
    assert_equal '-- ', footer_lines[0]
    assert_equal '', footer_lines[-1]
    diff = Redmine::UnifiedDiff.new(body_lines.join("\n") + "\n", :type => 'sbs')

    diff_size = diff.size
    diff_0_size = diff[0].size
    assert_equal 1, diff_size
    assert_equal 5, diff_0_size

    diff = Redmine::UnifiedDiff.new("test\n", :type => 'sbs')
    assert_equal 0, diff.size
    diff = Redmine::UnifiedDiff.new("test\ntest\n", :type => 'sbs')
    assert_equal 0, diff.size

    diff = Redmine::UnifiedDiff.new(raw, :type => 'sbs')
    assert_equal diff_size, diff.size
    assert_equal diff_0_size, diff[0].size

    diff = Redmine::UnifiedDiff.new(raw + "\n\n\n\n", :type => 'sbs')
    assert_equal diff_size, diff.size
    assert_equal diff_0_size, diff[0].size
  end
