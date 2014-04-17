require 'cinch'
require 'ostruct'
require 'open-uri'
require 'json'

module Cinch
  module Plugins
    class Bitcoin
      include Cinch::Plugin
      
      set :plugin_name, 'bitcoin'
      set :help, <<-USAGE.gsub(/^ {6}/, '')
        Bitcoin plugin that fetches results from Blockchain.info!
          Usage:
            * !btcv <currency>: Returns the latest value of 1 (one) Bitcoin in <currency>
            * !btc <currency> <Bitcoin amount>: Returns the value of <Bitcoin amount> in <currency>.
          USAGE
      
      match /btcv (\w{3})/
      
      def execute(m, currency)
        data = JSON.parse(open("http://blockchain.info/ticker").read)

        coins = ['USD', 'CNY', 'JPY', 'SGD', 'HKD', 'CAD', 'NZD', 'AUD', 'CLP', 'GBP', 'HKK', 'SEK', 'ISK', 'CHF', 'BRL', 'EUR', 'RUB', 'PLN', 'THB', 'KRW', 'TWD']

        currency = currency.upcase

        if !coins.include?(currency)
          m.reply "That currency isn't in my database!"
          m.user.notice "You can use: #{coins}"
          return
        end

          value = data[currency]['15m']
          value = value.round(2).to_f
          value = value.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse

          symbol = data[currency]['symbol']

          m.reply "Current value of 1 BTC in #{currency} is: #{symbol}#{value}", true
        end

        match /btc (\w{3}) (.+)/, method: :conversion

      def conversion(m, currency, btc)
        data = JSON.parse(open("http://blockchain.info/ticker").read)

        coins = ['USD', 'CNY', 'JPY', 'SGD', 'HKD', 'CAD', 'NZD', 'AUD', 'CLP', 'GBP', 'HKK', 'SEK', 'ISK', 'CHF', 'BRL', 'EUR', 'RUB', 'PLN', 'THB', 'KRW', 'TWD']

        currency = currency.upcase

        if !coins.include?(currency)
          m.reply "That currency isn't in my database!"
          m.user.notice "You can use: #{coins}"
          return
        end
          value = data[currency]['15m']
          value = value.round(2).to_f

          symbol = data[currency]['symbol']

          btc = btc.to_f

          conv = (btc * value).round(2)
          conv = conv.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse

          m.reply "The value of #{btc}BTC is #{symbol}#{conv}.", true
        end
      end
    end
  end