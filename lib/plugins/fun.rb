require 'cinch'
require_relative "config/check_ignore"

module Cinch
  module Plugins
    class Fun
      include Cinch::Plugin

      set :plugin_name, 'fun'
      set :help, <<-USAGE.gsub(/^ {6}/, '')
      This plugin simply contains some fun things that you can use in the channel.
      Usage:
      * !revive <user>: Calling this command will cause the bot to throw a "Phoenix Down" on <user>, reviving them.
      * !rose <user>: Calling this command will cause the bot to give a rose to <user> from you!
      USAGE

      match /revive (.+)/i, method: :revive

      def revive(m, user)
        return if check_ignore(m.user)
        if User(user) == m.bot
          samebot(m, user)
          return;
        end
        if m.channel.users.has_key?(User(user)) == false
          notinchan(m, user)
          return;
        end
        if User(user) == m.user
          itsyou(m, user)
          return;
        end
        sleep config[:delay] || 3
        m.channel.action "throws a Phoenix Down on #{User(user).nick}, effectively reviving them!"
      end


      def samebot(m, user)
        sleep config[:delay] || 3
        m.reply Format(:green, "That's me!")
      end

      def notinchan(m, user)
        sleep config[:delay] || 3
        m.reply Format(:green, "#{user} isn't in the channel")
      end

      def itsyou(m, user)
        sleep config[:delay] || 3
        m.reply Format(:green, "That's you!")
      end

      match /rose (.+)/, method: :rose

      def rose(m, user)
        usernick = User(user).nick
        return if check_ignore(m.user)

        return notinchan(m, user) if m.channel.users.has_key?(User(user)) == false

        if User(user) == m.user
          m.channel.action "gives #{usernick} a rose."
          m.reply Format(:green, "--<--<--{%s" % [Format(:red, "@")])
        else
          m.channel.action "gives #{usernick} a rose from #{m.user.nick}."
          m.reply Format(:green, "--<--<--{%s" % [Format(:red, "@")])
        end
      end
    end
  end
end

## Written by Richard Banks for Eve-Bot "The Project for a Top-Tier IRC bot.
## E-mail: namaste@rawrnet.net
## Github: Namasteh
## Website: www.rawrnet.net
## IRC: irc.sinsira.net #Eve
## If you like this plugin please consider tipping me on gittip