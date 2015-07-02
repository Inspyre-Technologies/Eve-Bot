require 'yaml'
require 'json'
require 'tempfile'
require_relative '../helpers/logger'

module Cinch
  module Plugins
    class ConfigChecks
      include Cinch::Plugin

      PluginName = "ConfigChecks"

      # This block checks for several files, and
      # if they are not there it will run the first-
      # run wizard for the associated core plugin.
      #
      # The files checked are as follows
      # - settings.yaml (basic bot settings)
      # - masters.yaml (administrator settings)
      # - plugins.rb (the final require script)
      def initialize(*args)
        super
        if File.exist?('config/settings/settings.yaml')
          @settings = YAML.load_file('config/settings/settings.yaml')
        else
          load 'lib/utils/first_run.rb'
          FirstRun.new(*args)
        end
        if File.exist?('config/settings/masters.yaml')
          @masterFile = YAML.load_file('config/settings/masters.yaml')
          @masterHistory = YAML.load_file('config/settings/logged.yaml')
        else
          load 'lib/utils/admin_first_run.rb'
          AdminFirstRun.new(*args)
        end
        if File.exist?('config/settings/plugins.rb')
          log_message("message", "Plugins file exists, starting bot...", PluginName)
        else
          log_message("message", "Plugins file does not exist, running first-run for plugins.", PluginName)
          load 'lib/utils/plugins_first_run.rb'
          PluginsFirstRun.new(*args)
          log_message("warn", "Restarting bot to apply first run changes...", PluginName, "yes")
          system("kill #{Process.pid}&& ruby Eve.rb")
        end
      end
    end
  end
end