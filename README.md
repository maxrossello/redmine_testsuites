# Redmine Test Suites

Tested with Redmine 3.4.8. Other supported versions come with dedicated tags.

Allows to run the Redmine test suite along with plugin tests, considering the different behaviors introduced by supported plugins over the Redmine default behavior.

## Overview

Redmine tests often fail when plugins are installed, because the plugins change the default behavior of the system. Furthermore, the plugins tests can be executed separately from the core Redmine ones.

A better environment for plugin development would encompass running core tests along with plugin tests, against the expected modified behavior.

This plugin installs itself only if RAILS_ENV="test", and does the following things:

- replicates the core Redmine tests into its own plugin space, modified according to *possibly* modified behavior by the *possible* presence of supported plugins (see list below)
- creates additional rake tasks for running plugin tests along with core tests:
    - **rake test:plugins** : runs all Redmine tests along with all the plugins tests (like test:plugins:all)
    - **rake test:plugins:all** : runs all Redmine tests along with all the plugins tests
    - **rake test:plugins:functionals** : run core functional tests along with plugins functional tests
    - **rake test:plugins:integration** : run core integration tests along with plugins integration tests
    - **rake test:plugins:routing** : run core routing tests along with plugins routing tests
    - **rake test:plugins:ui** : run core ui tests along with plugins ui tests
    - **rake test:plugins:units** : run core unit tests along with plugins unit tests
    
The Redmine core tests are cloned under the plugin itself and modified. Every modified line is kept in commented form, so that a diff against the verbatim tests is easy.

The plugin repository comes with a tag for each supported Redmine core version.

## Supported plugins

- [redmine_translation_terms](https://github.com/maxrossello/redmine_translation_terms) : allows to customize specific terms in Redmine translations (e.g. issue -> work item, project -> workspace) 

## How to support further plugins

- Fork this repository
- Run "rake test:plugins"
- Edit failing tests: duplicate the offending line(s) and keep the original ones commented.
The change shall encompass all cases of expected behaviors depending on whether all or a part of the supported plugins are installed or not. The presence of a plugin can be checked with:

	    if Plugin.installed? :my_plugin
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

