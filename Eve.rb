require 'cinch'
require 'redis'
require_relative "lib/eve/plugins/urban"
require_relative "lib/eve/plugins/help"
require_relative "lib/eve/plugins/seen"
require_relative "lib/eve/plugins/greeting"
require_relative "lib/eve/plugins/eightball"
require_relative "lib/eve/plugins/decide"
require_relative "lib/eve/plugins/memo"
require_relative "lib/eve/plugins/ai"
require_relative "lib/eve/plugins/control_panel"
require_relative "lib/eve/plugins/chanop_cp"
require_relative "lib/eve/plugins/private_cp"
require_relative "lib/eve/plugins/priv_chan_cp"
require_relative "lib/eve/plugins/fact_core"
require_relative "lib/eve/plugins/act_ai"
require_relative "lib/eve/plugins/url_scraper"
require_relative "lib/eve/plugins/twitter"
require_relative "lib/eve/plugins/twitter_status"
require_relative "lib/eve/plugins/plugin_management"
require_relative "lib/eve/plugins/valentine_boxx"
require_relative "lib/eve/plugins/wikipedia"
require_relative "lib/eve/plugins/weather"
require_relative "lib/eve/plugins/google"
require_relative "lib/eve/plugins/you_tube"
require_relative "lib/eve/plugins/math"
require_relative "lib/eve/plugins/bitcoin"
require_relative "lib/eve/plugins/user_info"
require_relative "lib/eve/plugins/isitup"
require_relative "lib/eve/plugins/relationship_handler"
require_relative "lib/eve/plugins/admin_handler"
require_relative "lib/eve/plugins/four_chan"
require_relative "lib/eve/plugins/dictionary"
require_relative "lib/eve/plugins/news"


# You should have something in the block below as it will have Eve report
# invalid or unauthorized use of her commands to the nicks you place in it
# Note: Please keep in mind that this doesn't check if the dispatch nick 
# is authed so if for some reason it is imperative that no one but the bot
# masters see output maybe it is wise to only put your nick in here and 
# make sure no one steals it!

Config = OpenStruct.new

Config.dispatch = ["foo", "bar", "you"]

# In the block below make sure to enter your server information as well as
# the channels that you want it to join. Don't be lazy!

bot = Cinch::Bot.new do
  configure do |c|
  c.server = "rawr.sinsira.net"
  c.channels = ["#Eve"]
  c.nick = "Eve"
  c.user = "Eve"
  c.realname = "Eve 6.0"
  c.plugins.plugins = [Cinch::Plugins::PluginManagement,
                       Cinch::Plugins::Urban,
                       Cinch::Plugins::Help,
                       Cinch::Plugins::Seen,
                       Cinch::Plugins::Greeting,
                       Cinch::Plugins::Eightball,
                       Cinch::Plugins::Decide,
                       Cinch::Plugins::Memo,
                       Cinch::Plugins::Ai,
                       Cinch::Plugins::ControlPanel,
                       Cinch::Plugins::ChanopCP,
                       Cinch::Plugins::PrivateCP,
                       Cinch::Plugins::PrivChanCP,
                       Cinch::Plugins::FactCore,
                       Cinch::Plugins::ActAI,
                       Cinch::Plugins::UrlScraper,
                       Cinch::Plugins::Twitter,
                       Cinch::Plugins::TwitterStatus,
                       Cinch::Plugins::ValentineBoxx,
                       Cinch::Plugins::Wikipedia,
                       Cinch::Plugins::Weather,
                       Cinch::Plugins::Google,
                       Cinch::Plugins::YouTube,
                       Cinch::Plugins::Math,
                       Cinch::Plugins::Bitcoin,
                       Cinch::Plugins::UserInfo,
                       Cinch::Plugins::Isitup,
                       Cinch::Plugins::RelationshipHandler,
                       Cinch::Plugins::AdminHandler,
                       Cinch::Plugins::FourChan,
                       Cinch::Plugins::Dictionary,
                       Cinch::Plugins::News];
  #c.plugins.options[Cinch::Plugins::UrlScraper] = { enabled_channels: ["#foo", "#bar" "#channel"] }
  #c.plugins.options[Cinch::Plugins::Greeting] = { enabled_channels: ["#foo", "#bar" "#channel"] }
  #c.plugins.options[Cinch::Plugins::TwitterStatus] = {
  #                                                   consumer_key:    'foo',
  #                                                   consumer_secret: 'foo',
  #                                                   access_token:     'foo',
  #                                                   access_token_secret:    'foo',
  #                                                   watchers:        { '#foo' => ['bar'] } }
  #c.plugins.options[Cinch::Plugins::Twitter] = { 
  #access_keys: { 
  #  consumer_key: "foo", 
  #  consumer_secret: "foo", 
  #  access_token: "foo", 
  #  access_token_secret: "foo" 
  #} 
#}
  c.plugins.options[Cinch::Plugins::Weather] = { key: 'foo' }
  c.password = "nspass"
  end
end

bot.start