require 'cinch'
require_relative "config/check_master"
require_relative "config/check_ignore"

module Cinch::Plugins
  class AdminHandler
    include Cinch::Plugin
    include Cinch::Helpers

    set :plugin_name, 'adminhandler'
    set :help, <<-USAGE.gsub(/^ {6}/, '')
    Commands to handle the masters of the bot.
    Usage:
    * !add-master <user>: Adds <user> as master, must be authenticated with NickServ.
    * !del-master <user>: Deletes <user> as a master of the bot.
    USAGE


    match /add-master (.+)/i, method: :set_master

    match /del-master (.+)/i, method: :del_master

    def set_master(m, target)
      unless check_master(m.user)
        m.reply Format(:red, "You are not authorized to use that command!")
        return;
      end
      mas = User(target)
      sleep config[:delay] || 4
      mas.refresh
      auth = mas.authname
      @storage[User(target).nick] ||= {}
      @storage[User(target).nick]['auth'] = auth
      @storage[User(target).nick]['master'] = true
      update_store
      m.reply "Added #{User(target).nick} as a master!"
    end

    def del_master(m, target)
      unless check_master(m.user)
        m.reply Format(:red, "You are not authorized to use that command!")
        return;
      end
      if @storage.key?(User(target).nick)
        if @storage[User(target).nick].key? 'master'
          mas = @storage[User(target).nick]
          mas.delete('master')
          update_store
          m.reply "Deleted #{User(target).nick} from the masters list"
        else
          m.reply "#{User(target).nick} isn't a master!"
        end
      end
    end

    def update_store
      synchronize(:update) do
        File.open('docs/userinfo.yaml', 'w') do |fh|
          YAML.dump(@storage, fh)
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
