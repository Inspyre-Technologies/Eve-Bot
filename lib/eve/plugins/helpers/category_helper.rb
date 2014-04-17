require 'json'
require 'open-uri'
require 'ostruct'
require 'cinch/toolbox'

module Cinch
  module Helpers
  
    def categories
      c_data = JSON.parse(open("http://api.feedzilla.com/v1/categories.json").read)
      c_list = []
      
      for i in c_data
        c_title = i['english_category_name']
        c_id    = i['category_id']
        
        c_list.push("%s [ %s ]" % [c_title, c_id])
      end
        return c_list
      end
      
    def sub_categories(id)
      sc_data = JSON.parse(open("http://api.feedzilla.com/v1/categories/#{id}/subcategories.json").read)
      sc_list = []
      
      for i in sc_data
        sc_title = i['display_subcategory_name']
        sc_id    = i['subcategory_id']
        
        sc_list.push("%s [ %s ]" % [sc_title, sc_id])
      end
        return sc_list
      end
      
    def execute_c_search(id, terms)
      search_c_data = JSON.parse(open("http://api.feedzilla.com/v1/categories/#{id}/articles/search.json?q=#{terms}&count=4").read)
      s_c_data = search_c_data['articles']
      search_c_list = []
      
      for i in s_c_data
        article_source   = i['source']
        article_title    = i['title']
        article_summary  = i['summary']
        article_url      = i['url']
        
        url = article_url
        url = Cinch::Toolbox.shorten(url)

        url = /"shorturl": "(.+)"/.match(url)[1]

        summary = article_summary[0..200]

        summary_s = summary.gsub! /\n/, ' '

        search_c_list.push("%s | Title \"%s\" | Summary: %s [ %s ]" % [article_source, article_title, summary, url])
      end
        return search_c_list
      end

      def execute_sc_search(id, sc_id, terms)
        search_sc_data = JSON.parse(open("http://api.feedzilla.com/v1/categories/#{id}/subcategories/#{sc_id}/articles/search.json?q=#{terms}&count=4").read)
        s_sc_data =           search_sc_data['articles']
        search_sc_list = []
      
      for i in s_sc_data
        article_source   = i['source']
        article_title    = i['title']
        article_summary  = i['summary']
        article_url      = i['url']
        
        url = article_url
        url = Cinch::Toolbox.shorten(url)

        url = /"shorturl": "(.+)"/.match(url)[1]

        summary = article_summary[0..200]

        summary_s = summary.gsub! /\n/, ' '

        search_sc_list.push("%s | Title \"%s\" | Summary: %s [ %s ]" % [article_source, article_title, summary_s, url])
      end
        return search_sc_list
      end

    def fetch_news
      news_data = JSON.parse(open("http://api.feedzilla.com/v1/categories/26/articles.json?&count=4").read)
      news_articles = news_data['articles']
      news_list = []

      for i in news_articles
        article_source   = i['source']
        article_title    = i['title']
        article_summary  = i['summary']
        article_url      = i['url']

        puts article_url

        url = article_url
        url = Cinch::Toolbox.shorten(url)

        url = /"shorturl": "(.+)"/.match(url)[1]

        puts url.class

        summary = article_summary[0..200]

        summary_s = summary.gsub! /\n/, ' '

        news_list.push("%s | Title \"%s\" | Summary: %s [ #{url} ]" % [article_source, article_title, summary_s])
      end
        return news_list
      end

      def c_top_news(id)
        c_news_data = JSON.parse(open("http://api.feedzilla.com/v1/categories/#{id}/articles.json?&count=4").read)
        c_news_articles = c_news_data['articles']
        c_news_list = []

        for i in c_news_articles
          article_source   = i['source']
          article_title    = i['title']
          article_summary  = i['summary']
          article_url      = i['url']


          url = article_url
          url = Cinch::Toolbox.shorten(url)

          url = /"shorturl": "(.+)"/.match(url)[1]

          summary = article_summary[0..200]

          summary_s = summary.gsub! /\n/, ' '

          c_news_list.push("%s | Title \"%s\" | Summary: %s [ #{url} ]" % [article_source, article_title, summary_s])
        end
          return c_news_list
        end

      def sc_top_news(id, sc_id)
        sc_news_data = JSON.parse(open("http://api.feedzilla.com/v1/categories/#{id}/subcategories/#{sc_id}/articles.json?&count=4").read)
        sc_news_articles = sc_news_data['articles']
        sc_news_list = []

        for i in sc_news_articles
          article_source   = i['source']
          article_title    = i['title']
          article_summary  = i['summary']
          article_url      = i['url']


          url = article_url
          url = Cinch::Toolbox.shorten(url)

          url = /"shorturl": "(.+)"/.match(url)[1]

          summary = article_summary[0..200]

          summary_s = summary.gsub! /\n/, ' '

          sc_news_list.push("%s | Title \"%s\" | Summary: %s [ #{url} ]" % [article_source, article_title, summary_s])
        end
          return sc_news_list
        end

    end
  end
  