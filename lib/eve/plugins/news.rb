# @author Richard Banks <namaste@rawrnet.net>

# Feel free to join us in #Lobby on irc://rawr.sinsira.net where you can test this gem and get help!

require 'cinch'
require 'ostruct'
require 'open-uri'
require 'json'
require 'cgi'
require 'cinch/toolbox'
require_relative "helpers/category_helper.rb"

module Cinch
  module Plugins
    class News
      include Cinch::Plugin
      
      set :plugin_name, 'news'
      set :help, <<-USAGE.gsub(/^ {6}/, '')
        This plugin is a comprehensive news aggregator and contacts several sources for articles.
        Enable/Disable Usage:
        * ~n-categories: This command returns all the categories that you can choose from in a PM.
        * ~n-subcategories <category ID>: This command returns all the subcategories of the specified category and their useable ID.
        * ~news: This command retrieves the top three articles from the Top Stories subcategory of the Top News category.
        * ~news <category ID>: This command retrieves the top three articles from the specified category.
        * ~news <category ID> <subcategory ID>: This command retrieves the top three articles from the specified subcategory of the specified category.
        * ~s-category <category id> <query>: This command searches the specified category for your query.
        USAGE
      
      match /n-categories/, method: :list_categories
      
      match /n-subcategories (.+)/, method: :list_subs
      
      match /news$/, method: :top_news

      match /news (.+)$/, method: :c_topnews

      match /news (.+?) (.+)/, method: :sc_topnews
      
      match /s-category (.+?) (.+)/, method: :search_category

      match /s-subcategory (.+?) (.+?) (.+)/, method: :search_subcategory
      
      def list_categories(m)
        cat_list = categories
        ca_list = cat_list.join(", ")
        m.user.notice "#{ca_list}"
      end
      
      def list_subs(m, c_id)
        sc_list = sub_categories(c_id)
        s_list = sc_list.join(", ")
        m.user.notice "#{s_list}"
      end
    
      
      def search_category(m, id, terms)
        terms.gsub! /\s/, '+'
        search_list = execute_c_search(id, terms)
        search_list[0..2].each{|i| m.reply i}
          rescue OpenURI::HTTPError
            m.reply "Error: #{$!}"
          end

      def search_subcategory(m, id, sc_id, terms)
        terms.gsub! /\s/, '+'
        sc_search_list = execute_sc_search(id, sc_id, terms)
        sc_search_list[0..2].each{|i| m.reply i}
          rescue OpenURI::HTTPError
            m.reply "Error #{$!}"
          end 

      def top_news(m)
        news = fetch_news
        news[0..2].each{|i| m.reply i}
          rescue OpenURI::HTTPError
            m.reply "Error #{$!}"
          end

      def c_topnews(m, id)
        c_news = c_top_news(id)
        c_news[0..2].each{|i| m.reply i}
          rescue OpenURI::HTTPError
            m.reply "Error #{$!}"
          end

      def sc_topnews(m, id, sc_id)
        sc_news = sc_top_news(id, sc_id)
        sc_news[0..2].each{|i| m.reply i}
          rescue OpenURI::HTTPError
            m.reply "Error #{$!}"
          end


        end
  end
end