require_relative '../helpers/logger'
require_relative '../helpers/file_handler'

module Cinch
  module Plugins
    class AiConfig
      include Cinch::Plugin

      Plugin_Name = "EveMotion::AIConfig"
      def initialize(*args)
        super
        @aiConf = {} unless @aiConf
        puts "\e[H\e[2J"
        say("Welcome to <%= color('eveMotion', BOLD, YELLOW) %>!")
        say("<%= color('eveMotion', BOLD, YELLOW) %> attempts to mimic/produce fuzzy logic for your IRC bot")
        say("Now we need to go through and set the basic settings for your bot!")
        choose do |gender|
          gender.prompt = "First, what will be the bot's gender?: "
          gender.default = "Female"
          gender.choice("Male") do @aiConf['gender'] = "male" end
          gender.choice("Female") do @aiConf['gender'] = "female" end
          gender.confirm = "\nAre you sure? [yes/no]: "
          gender.responses[:ask_on_error] = gender
        end

        choose do |sexuality|
          sexuality.prompt = "What will be #{botnick}'s sexuality?: "
          sexuality.default = "Bisexual"
          sexuality.choice("Heterosexual") do @aiConf['sexuality'] = "heterosexual" end
          sexuality.choice("Homosexual") do @aiConf['sexuality'] = "homosexual" end
          sexuality.choice("Bisexual") do @aiConf['sexuality'] = "bisexual" end
          sexuality.choice("Asexual") do @aiConf['sexuality'] = "asexual" end
          sexuality.confirm = "\nAre you sure? [yes/no]: "
          sexuality.responses[:ask_on_error] = sexuality
        end
        choose do |disposition|
          disposition.prompt = "What will be #{botnick}'s general disposition? "
          disposition.choice("Cheery") do @aiConf['disposition'] = "cheery" end
          disposition.choice("Depressed") do @aiConf['disposition'] = "depressed" end
          disposition.choice("Extreme") do @aiConf['disposition'] = "extreme" end
          disposition.choice("Misanthropic (hatred of human-kind)") do @aiConf['disposition'] = "misanthropic" end
          disposition.confirm = "\nAre you sure? [yes/no]: "
          disposition.responses[:ask_on_error] = disposition
        end
        store_conf
      end

      def store_conf
        log_message("message", "Writing eveMotion file...", Plugin_Name)
        begin
          synchronize(:update) do
            File.open('config/settings/eveMotion.yaml', 'w') do |fh|
              YAML.dump(@aiConf, fh)
            end
          end
        rescue
          puts "#{$!}"
          log_message("error", "Error: #{$!}", Plugin_Name)
          abort("Exiting due to above error!")
        end
        log_message("message", "eveMotion file written!", Plugin_Name)
        say("Master file written!")
      end

      def delete_conf
        log_message("warn", "Deleting eveMotion.yaml...", Plugin_Name)
        begin
          if File.exist?('config/settings/eveMotion.yaml')
            File.delete('config/settings/eveMotion.yaml')
          else
            log_message("warn", "The eveMotion.yaml file does not exist", Plugin_Name)
          end
        rescue
          log_message("error", "There seems to have been an issue deleting eveMotion.yaml: #{$!}", Plugin_Name)
        end
      end
    end
  end
end
