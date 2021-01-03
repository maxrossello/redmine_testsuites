# Copyright (C) 2006-2017  Jean-Philippe Lang
    raw = <<-DIFF
--- test.orig.txt Wed Feb 15 16:10:39 2012
+++ test.new.txt  Wed Feb 15 16:11:25 2012
@@ -1,5 +1,5 @@
 Semicolons were mysteriously appearing in code diffs in the repository
 
-void DoSomething(std::auto_ptr<MyClass> myObj)
+void DoSomething(const MyClass& myObj)
 
DIFF

    diff = Redmine::UnifiedDiff.new(<<-DIFF
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
    )
    diff = Redmine::UnifiedDiff.new(<<-DIFF
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
    )
    diff = Redmine::UnifiedDiff.new(<<-DIFF
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
    )
    diff = Redmine::UnifiedDiff.new(<<-DIFF)
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

    diff = Redmine::UnifiedDiff.new(<<-DIFF
--- test1.txt
+++ b/test02.txt
@@ -1 +0,0 @@
-modify test1
DIFF
    )
    diff = Redmine::UnifiedDiff.new(<<-DIFF
--- a/test1.txt
+++ a/test02.txt
@@ -1 +0,0 @@
-modify test1
DIFF
    )
    diff = Redmine::UnifiedDiff.new(<<-DIFF
--- a/test1.txt
+++ test02.txt
@@ -1 +0,0 @@
-modify test1
DIFF
    )
    ja = "  text_tip_issue_end_day: "
    ja += "\xe3\x81\x93\xe3\x81\xae\xe6\x97\xa5\xe3\x81\xab\xe7\xb5\x82\xe4\xba\x86\xe3\x81\x99\xe3\x82\x8b<span>\xe3\x82\xbf\xe3\x82\xb9\xe3\x82\xaf</span>".force_encoding('UTF-8')
      assert_equal ja, diff.first[4].html_line_left
    ru = "        other: &quot;\xd0\xbe\xd0\xba\xd0\xbe\xd0\xbb\xd0\xbe %{count} \xd1\x87\xd0\xb0\xd1\x81<span>\xd0\xb0</span>&quot;".force_encoding('UTF-8')
      assert_equal ru, diff.first[3].html_line_left
    raw = <<-DIFF
--- a.txt	2013-04-05 14:19:39.000000000 +0900
+++ b.txt	2013-04-05 14:19:51.000000000 +0900
@@ -1,3 +1,3 @@
 aaaa
-abc
+abcd
 bbbb
DIFF
    raw = <<-DIFF
--- a.txt	2013-04-05 14:19:39.000000000 +0900
+++ b.txt	2013-04-05 14:19:51.000000000 +0900
@@ -1,3 +1,3 @@
 aaaa
-abc
+zabc
 bbbb
DIFF
    ja1 = "\xe6\x97\xa5\xe6\x9c\xac<span></span>".force_encoding('UTF-8')
    ja2 = "\xe6\x97\xa5\xe6\x9c\xac<span>\xe8\xaa\x9e</span>".force_encoding('UTF-8')
      assert_equal ja1, diff.first[1].html_line_left
      assert_equal ja2, diff.first[1].html_line_right
    ja1 = "<span></span>\xe6\x97\xa5\xe6\x9c\xac".force_encoding('UTF-8')
    ja2 = "<span>\xe3\x81\xab\xe3\x81\xa3\xe3\x81\xbd\xe3\x82\x93</span>\xe6\x97\xa5\xe6\x9c\xac".force_encoding('UTF-8')
      assert_equal ja1, diff.first[1].html_line_left
      assert_equal ja2, diff.first[1].html_line_right
    ja1 = "\xe6\x97\xa5\xe6\x9c\xac<span>\xe8\xa8\x98</span>".force_encoding('UTF-8')
    ja2 = "\xe6\x97\xa5\xe6\x9c\xac<span>\xe5\xa8\x98</span>".force_encoding('UTF-8')
      assert_equal ja1, diff.first[1].html_line_left
      assert_equal ja2, diff.first[1].html_line_right
    # UTF-8 The 2nd byte differs. 
    ja1 = "\xe6\x97\xa5\xe6\x9c\xac<span>\xe8\xa8\x98</span>".force_encoding('UTF-8')
    ja2 = "\xe6\x97\xa5\xe6\x9c\xac<span>\xe8\xaa\x98</span>".force_encoding('UTF-8')
      assert_equal ja1, diff.first[1].html_line_left
      assert_equal ja2, diff.first[1].html_line_right
    # UTF-8 The 2nd byte differs. 
    ja1 = "\xe6\x97\xa5\xe6\x9c\xac<span>\xe8\xa8\x98</span>ok".force_encoding('UTF-8')
    ja2 = "\xe6\x97\xa5\xe6\x9c\xac<span>\xe8\xaa\x98</span>ok".force_encoding('UTF-8')
      assert_equal ja1, diff.first[1].html_line_left
      assert_equal ja2, diff.first[1].html_line_right