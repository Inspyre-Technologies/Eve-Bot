require 'cinch'
require 'yaml'
require 'json'
require 'highline'
require_relative '../helpers/logger'
require_relative '../helpers/geolocation'

module Cinch
  module Plugins
    class UIFirstRun
      include Cinch::Plugin

      def initialize(*args)
        super
        if File.exist?('config/settings/user_info.yaml')
          log_message("message", "Found user_info.yaml, proceeding with bot start...")
          @userSettings = YAML.load_file('config/settings/user_info.yaml')
        else
          log_message("warn", "Could not find user_info.yaml, proceeding with UserInfo first-run...")
          log_message("message", "Looking for masters.yaml...")
          if File.exist?('config/settings/masters.yaml')
            log_message("message", "Found masters.yaml, proceeding...")
            @masterFile = YAML.load_file('config/settings/masters.yaml')
            puts "\e[H\e[2J"
            user_nick = @masterFile.keys[0].downcase
          else
            log_message("error", "Could not find masters.yaml file.")
            abort("Please go through the administrator first-run wizard before configuring this plugin!")
          end
          say("We are now going to set up your information for the UserInfo plugin, #{user_nick}.")
          @userSettings = {}
          @userSettings[user_nick] ||= {}
          if agree("Would you like to start off by providing me with another name for you, like an irl nickname or real name? [yes/no]: ")
            irl_name = ask("Please enter your name (irl nickname, first name): ") {|q|
              q.validate = /\A\w+\Z/
              q.responses[:not_valid] = "You can't have a blank name!"
              q.responses[:ask_on_error] = "Your name: "
              q.confirm = "Are you sure you wish to set your nick name to <%= @answer %>? [yes/no]: "
            }
            @userSettings[user_nick]['irl_name'] = irl_name
          else
            @userSettings[user_nick]['irl_name'] = false
          end
          say("For different AI aspects of the bot, it's helpful to know your gender.")
          if agree("Would you like to provide your gender to the bot for better tuned responses? [yes/no]: ")
            choose do |gender|
              gender.prompt = "What is your gender? "
              gender.choice("Male") { @userSettings[user_nick]['gender'] = "male" }
              gender.choice("Female") { @userSettings[user_nick]['gender'] = "female"}
              gender.confirm = "Are you sure? [y/n]: "
            end
            log_message("message", "Saving gender...")
          else
            @userSettings[user_nick]['gender'] = false
          end
          say("If you have the weather plugin enabled you can access your weather from a discrete and simple command that will deliver your weather without revealing your location.")
          if agree("Would you like to provide your postal code for discrete and easy access to your weather from IRC? [yes/no]: ")
            begin
              location = ask("Please provide your location. You can enter a postal code or city and state/province: ") {|q|
                q.responses[:not_valid] = "You can't have a blank location!"
                q.responses[:ask_on_error] = "Your location: "
                q.confirm = "I will be searching for <%= @answer %>, are you sure this is correct? [yes/no]: "
              }
              if geolocation(location)
                say("Okay #{user_nick}, I found a weather station at #{@address}. The coordinates are #{@lat},#{@lng}.")
                if agree("Does that sound correct? [yes/no]: ")
                  log_message("message", "Saving location data...")
                  @userSettings[user_nick]['address']     = @address
                  @userSettings[user_nick]['coordinates'] = "#{@lat},#{@lng}"
                  log_message("message", "Location data saved!")
                else
                  raise ArgumentError.new("You've indicated the location I've found is incorrect. Returning...")
                end
              else
                raise ArgumentError.new("Returning...")
              end
            rescue
              retry
            end
          else
            @userSettings[user_nick]['address'] = false
            @userSettings[user_nick]['coordinates'] = false
          end
          say("If you have the NowPlaying plugin enabled; you can access your LastFM account's scrobbling information to fetch what you're currently listenting to, and return it to the channel.")
          if agree("Would you like to add your LastFM username to the bot? [yes/no]: ")
            lastfm_username = ask("Please provide your LastFM username: ") {|q|
              q.validate = /\A\w+\Z/
              q.responses[:ask_on_error] = "Your LastFM username: "
              q.responses[:not_valid]  = "You can't have a blank LastFM username!"
              q.confirm = "I will be searching for <%= @answer %> when we start the LastFM plugin, are you sure this is correct? [yes/no]: "
            }
            log_message("message", "Saving LastFM user name...")
            @userSettings[user_nick]['lfm_username'] = lastfm_username
          else
            @userSettings[user_nick]['lfm_username'] = false
          end
          say("#{user_nick}, if you have a <%= color('Twitter', BOLD, BLUE) %> account you can save your handle to the bot for easy access to your tweets from IRC!")
          if agree("Would you like to add your <%= color('Twitter', BOLD, BLUE) %> handle to the bot? [yes/no]: ")
            twitter_handle = ask("Please provide your <%= color('Twitter', BOLD, BLUE) %> handle: ") {|q|
              q.validate = /\A\w+\Z/
              q.responses[:ask_on_error] = "Your <%= color('Twitter', BOLD, BLUE) %> handle: "
              q.responses[:not_valid] = "You can't have a blank <%= color('Twitter', BOLD, BLUE) %> handle!"
              q.confirm = "I will be checking the validity of the <%= color('Twitter', BOLD, BLUE) %> handle; <%= @answer %> once the <%= color('Twitter', BOLD, BLUE) %> plugin starts. Is <%= @answer %> correct? [yes/no]: "
            }
            log_message("message", "Saving Twitter handle...")
            @userSettings[user_nick]['twitter_handle'] = twitter_handle
          else
            @userSettings[user_nick]['twitter_handle'] = false
          end
          say("If you give me your birthdate I can tell how old you are, and I can even give you a special treat on your birthday!")
          begin
            if agree("Would you like to add your birthday to the bot? [yes/no]: ")
              birthdate = ask("Please provide your birthdate: ") {|b|
                b.validate = Proc.new {|bday|
                  Date.parse(bday)
                }
                b.responses[:ask_on_error] = "Your birthdate: "
                b.responses[:not_valid] = "<%= @answer %> is not a valid date!"
                b.confirm = "Are you sure? [yes/no]: "
              }
              now = Date.today
              dob = Date.parse(birthdate)
              age = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
              if agree("According to the birthdate you provided me, you are #{age} years-old, is this correct? [yes/no]: ")
                log_message("message", "Saving birthdate...")
                @userSettings[user_nick]['birthdate'] = dob.to_s
              else
                raise ArgumentError.new("You've indicated that the inputted birthdate is wrong...")
              end
            else
              @userSettings[user_nick]['birthdate'] = false
            end
          rescue
            retry
          end
          say("The bot can greet you with a custom greeting when you enter a channel it's in.")
          if agree("Would you like to set a custom greeting to be used when you join a mutual channel with the bot? [yes/no]: ")
            greeting = ask("What would you like your greeting to be? ") {|q|
              q.responses[:ask_on_error] = "Your custom greeting: "
              q.responses[:not_valid] = "You can't have a blank custom greeting!"
              q.confirm = "You've set your greeting as '<%= @answer %> | Are you sure you want this custom greeting? "
            }
            log_message("message", "Saving custom greeting...")
            @userSettings[user_nick]['greeting'] = greeting
          else
            @userSettings[user_nick]['greeting'] = false
          end
          update_settings
        end
      end

      def update_settings
        log_message("message", "Writing user information file...")
        begin
          synchronize(:update) do
            File.open('config/settings/user_info.yaml', 'w') do |fh|
              YAML.dump(@userSettings, fh)
            end
          end
        rescue
          puts "#{$!}"
          log_message("error", "Error: #{$!}")
          abort("Exiting due to above error!")
        end
        log_message("message", "User information file written!")
        say("Master file written!")
      end

      def delete_settings
        log_message("warn", "Deleting user_info.yaml...")
        begin
          if File.exist?('config/settings/user_info.yaml')
            File.delete('config/settings/user_info.yaml')
          else
            log_message("warn", "The user_info.yaml file does not exist")
          end
        rescue
          log_message("error", "There seems to have been an issue deleting user_info.yaml: #{$!}")
        end
      end
    end
  end
end
