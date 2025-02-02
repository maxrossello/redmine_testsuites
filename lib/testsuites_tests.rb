require 'active_record/migration'
require 'redmine/plugin_loader'
require 'redmine/plugin'

module TestsuitesTests
  def self.unit_tests
    FileList["plugins/*/test/unit/**/*_test.rb"]
  end

  def self.functional_tests
    FileList["plugins/*/test/functional/**/*_test.rb"]
  end

  def self.integration_tests
    FileList["plugins/*/test/integration/**/*_test.rb"]
  end

  def self.routing_tests
    FileList["plugins/*/test/integration/routing/*_test.rb"] + 
    FileList["plugins/*/test/integration/api_test/*_routing_test.rb"] + 
    FileList["plugins/*/test/routing/*_test.rb"]
  end

  def self.helper_tests
    FileList["plugins/*/test/helpers/**/*_test.rb"]
  end

  def self.system_tests
    FileList["plugins/*/test/system/**/*_test.rb"]
  end

  def self.all_tests
    # system tests excluded
    unit_tests + functional_tests + integration_tests + routing_tests + helper_tests
  end
end
