require 'cinch'
require 'open-uri'
require 'nokogiri'
require 'cgi'

# This plugin searches Urban Dictionary and prints the result to the IRC
# channel. 

module Cinch::Plugins
  class Urban
    include Cinch::Plugin
    
    set :plugin_name, 'urban'
    set :help, <<-USAGE.gsub(/^ {6}/, '')
      This plugin searches Urban Dictionary and prints the result to the IRC channel that the command is called in.
      Usage:
      - ~urban <query>: Has the bot look up the query/word and return to the channel with the result (if any)
    USAGE

    match /urban ([a-zA-Z ]+) ?(\d)?/
    
    def execute(m, word, number)
      
      number ||= 0

      url = "http://www.urbandictionary.com/define.php?term=#{CGI.escape(word)}"
      html = open(url).read
      doc = Nokogiri::HTML(html)

      return m.reply "There are no results for #{word}." if !doc.css('.word').any?

      if doc.css('.word').any?
        word = doc.css('.word').first.content.strip
        definitions = doc.css('.meaning').map{|d| d.content.strip }
        examples = doc.css('.example').map{|e| e.content.strip }

        count = definitions.count
        
        return m.reply Format(:red, " There are only #{count - 1} entries matching #{word}!!") if number.to_i > definitions.count.to_i - 1

        if number.to_i > 0
          define = definitions[number.to_i]
          example = examples[number.to_i]
          example = CGI.unescape_html(example).gsub( %r{</?[^>]+?>}, ' ' )
          count = definitions.count
 
          m.reply "#{number}: #{define} | There are #{count - 2} other definitions."
          m.user.notice "Example: #{examples[number.to_i]}"
        else
          m.reply "#{definitions[0]} | There are #{definitions.count} total entries."
          m.user.notice "Example: #{examples[0]}"
        end
      end
    end
  end
end