def unit_tests
  FileList["plugins/*/test/unit/**/*_test.rb"]
end

def functional_tests
  FileList["plugins/*/test/functional/**/*_test.rb"]
end

def integration_tests
  FileList["plugins/*/test/integration/**/*_test.rb"]
end

def routing_tests
  FileList["plugins/*/test/integration/routing/*_test.rb"] + 
    FileList["plugins/*/test/integration/api_test/*_routing_test.rb"] + 
      FileList["plugins/*/test/routing/*_test.rb"]
end

def helper_tests
  FileList["plugins/*/test/helpers/*_test.rb"]
end

def system_tests
  FileList["plugins/*/test/system/*_test.rb"]
end

def all_tests
  # system tests excluded
  unit_tests + functional_tests + integration_tests + routing_tests + helper_tests
end