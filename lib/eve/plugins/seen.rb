# -*- coding: utf-8 -*-
require 'cinch'
require 'cinch/toolbox'
require 'yaml'
require 'time-lord'

module Cinch
  module Plugins
    class Seen
      include Cinch::Plugin
      
      Activity = Struct.new(:nick, :time, :message, :channel)
      
      listen_to :channel
      
      set :plugin_name, 'seen'
      set :help, <<-USAGE.gsub(/^ {6}/, '')
      Allows you to control the basic functions of the bot.
      Usage:
	* !seen <user>: The bot searches for the last time <user> spoke and returns with the results.
      USAGE
      
      match /seen ([^\s]+)\z/
      
      def initialize(*args)
        super
          if File.exist?('docs/seen.yaml')
            @storage = YAML.load_file('docs/seen.yaml')
          else
	    @storage = {}
          end
        end
        
      def listen(m)
        nick = m.user.nick
        channel = m.channel.name
        @storage[nick.downcase] ||= {}
        @storage[nick.downcase]['seen'] =
        Activity.new(nick, Time.now, m.message, channel)
        update_store
      end
      
      def execute(m, nick)
        return if pm(m)
	unless m.user.nick.downcase == nick.downcase
	  m.reply seen(nick), true
        end
      end
      
      private
      
      def seen(nick)
        @storage[nick.downcase] ||= {}
        seen = @storage[nick.downcase]['seen']
        
        if seen.nil?
          "I have no record of seeing #{nick} before!"
        else
          "I last saw #{seen.nick} #{seen.time.ago.to_words} " +
          "saying '#{seen.message}' in #{seen.channel}"
        end
      end
      
      def pm(m)
       return false unless m.channel.nil?
       m.reply 'You must use that command in the main channel.'
       true
     end
     
     def update_store
       synchronize(:update) do
       File.open('docs/seen.yaml', 'w') do |fh|
       YAML.dump(@storage, fh)
     end
     
     def reload
       if File.exist?('docs/seen.yaml')
         @storage = YAML.load_file('docs/seen.yaml')
       else
         @storage = {}
       end
     end
   end
 end
 end
 end
 end