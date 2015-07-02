require 'highline'
require_relative 'timestamp'
require_relative 'file_handler'

module Cinch
  module Helpers

    def log_message(level, message, plugin_name="Core", timer="no")
      time = timestamp
      name = "| <%= color('#{plugin_name}', BOLD, UNDERLINE, GREEN) %> |"
      if level == "message"
        indicator  = "<%= color('--', BOLD, GREEN) %>"
        logMessage = "<%= color('#{time} #{name} #{indicator} #{message}', GREEN) %>"
      end
      if level == "warn"
        indicator  = "<%= color('**', BOLD, YELLOW) %>"
        logMessage = "<%= color('#{time} #{name} #{indicator} #{message}', YELLOW) %>"
      end
      if level == "error"
        indicator  = "<%= color('!!', BOLD, RED) %>"
        logMessage = "<%= color('#{time} #{name} #{indicator} #{message}', RED) %>"
        time="yes"
      end
      say("#{@logMessage}")
      sleep(2) if timer == "yes"
    end
  end
end
