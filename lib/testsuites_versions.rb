module Testsuites
  module Versions
    def self.check_plugin_versions(supported_plugins)
      Redmine::Plugin.all.each do |plugin|
        name = plugin.id
        if nil == supported_plugins[name]
          puts "WARNING: Plugin #{name.to_s} is not supported by redmine_testsuites"
        else
          current = plugin.version.split('.').collect(&:to_i)
          list = supported_plugins[name]
          unless list.is_a? Array
            list = [list]
          end
          
          supported = false
          list.each do |conditions|
            supported = true
            conditions.each do |key, value|
              varr = value.split('.').collect(&:to_i)
              case key
              when :version
                supported = false unless (current <=> varr) == 0
              when :version_or_higher
                supported = false unless (current <=> varr) >= 0
              when :version_lower_than
                supported = false unless (current <=> varr) < 0
              when :tilde_greater_than
                supported = false unless (current[0, varr.count-1] <=> varr[0..-2]) == 0
                supported = false unless (current <=> varr) >= 0
              else
                raise "Unknown plugin version condition type: #{key.to_s}"
              end
            end
            
            break if supported
          end
          
          unless supported
            puts "WARNING: Plugin #{name.to_s} version #{plugin.version} is not supported by redmine_testsuites"
          end
        end
      end
    end
  end
end