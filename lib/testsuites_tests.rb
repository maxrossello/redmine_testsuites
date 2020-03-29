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
  FileList["plugins/*/test/integration/routing/*_test.rb"] 
end

def ui_tests
  FileList["plugins/*/test/ui/**_test_ui.rb"]
end

def all_tests
  unit_tests + functional_tests + integration_tests + ui_tests + routing_tests 
end
