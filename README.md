# Redmine Test Suites

Tested with Redmine version matching the plugin version. Other supported versions come with dedicated tags.

Allows to run the Redmine test suite along with plugin tests, considering the different behaviors introduced by supported plugins over the Redmine default behavior.

Furthermore, the plugin adds tasks to run byebug and minitest_bisect over the very same test list and test order as the plain test task.

## Overview

Redmine tests often fail when plugins are installed, because the plugins change the default behavior of the system. Furthermore, the plugins tests can be executed separately from the core Redmine ones.

A better environment for plugin development would encompass running core tests along with plugin tests, against the expected modified behavior.

This plugin installs itself only if RAILS_ENV="test", but like other plugins, its rake tasks are always loaded. It does the following things:

- replicates the core Redmine tests into its own plugin space, modified according to *possibly* modified behavior by the *possible* presence of supported plugins (see list below)

- creates additional rails tasks for running plugin tests along with core tests:
    - **redmine:test** : runs core tests along with all the plugins tests (like redmine:test:all)
    - **redmine:test:all** : runs all core tests along with all the plugins tests
    - **redmine:test:functionals** : run core functional tests along with plugins functional tests
    - **redmine:test:helpers**: run core helpers tests along with plugins helpers tests
    - **redmine:test:integration** : run core integration tests along with plugins integration tests
    - **redmine:test:routing** : run core routing tests along with plugins routing tests
    - **redmine:test:units** : run core unit tests along with plugins unit tests
    
    Example:
*RAILS_ENV="test" bundle exec rails redmine:test:units TESTOPTS="--seed 45334"*
    
- creates additional rails tasks for running [minitest_bisect](https://github.com/seattlerb/minitest-bisect) on same files selected by redmine:test tasks, by using the **redmine:bisect** prefix. Environment variable *TESTOPTS* can be used to pass additional arguments, for example the offending seed.

  Example:
  *RAILS_ENV="test" bundle exec rails redmine:bisect:units TESTOPTS="--seed 45334"*

- creates additional rails tasks for running [byebug](https://github.com/deivid-rodriguez/byebug) on same files selected by redmine:test tasks, by using the **redmine:byebug**  prefix. Environment variable *TESTOPTS* can be used to pass additional arguments, for example the offending seed.

    Example:
    *RAILS_ENV="test" bundle exec rails redmine:byebug:units TESTOPTS="--seed 45334"*

The Redmine core tests are cloned under the plugin itself and then modified. Every modified line is kept in commented form, so that a diff against the verbatim tests is easy.

The plugin repository comes with a tag for each supported Redmine core version.

## Supported plugins

- [redmine_translation_terms](https://github.com/maxrossello/redmine_translation_terms) : allows to customize specific terms in Redmine translations (e.g. issue -> work item, project -> workspace) in order to better adapt the issue tracker to a specific task
- [redmine_base_deface](https://github.com/jbbarth/redmine_base_deface) : manage view modifications in plugins
- [redmine_better_overview](https://github.com/maxrossello/redmine_better_overview) : provides a better projects overview

## How to support further plugins

- Fork this repository
- Run "bundle exec rails redmine:test"
- Edit failing tests: duplicate the offending line(s) and keep the original ones commented.
The change shall encompass all cases of expected behaviors depending on whether all or a part of the supported plugins are installed or not. The presence of a plugin can be checked with:

	    if Redmine::Plugin.installed? :my_plugin
	        <expected behavior with my_plugin installed>
	    else
	        <expected behavior without my_plugin installed>
	    end

- Issue a merge request

## Installation

Install this plugin into the Redmine plugins folder.

    cd {redmine root}
    git clone https://github.com/maxrossello/redmine_testsuites.git plugins/redmine_testsuites
    bundle install

Finally restart your server.

