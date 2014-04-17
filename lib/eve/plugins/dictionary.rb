require 'cinch'
require 'ostruct'
require 'open-uri'
require 'json'
require 'cgi'

module Cinch
  module Plugins
    class Dictionary
      include Cinch::Plugin

      set :plugin_name, 'dictionary'
      set :help, <<-USAGE.gsub(/^ {6}/, '')
        This plugin searches for definitions.
          Usage:
            * ~define <word>: Fetches and returns the definition for the given word.
        USAGE

      match /define (.+)/i, method: :define

      def define(m, query)
        data = fetch_definition(m, query)
        return m.reply Format(:red, "I'm sorry but I couldn't find the definition of #{query}.") if data.empty?
        definition(m, data)
      end

      def fetch_definition(m, word)
        data = JSON.parse(open("http://api.wordnik.com:80/v4/word.json/#{word}/definitions?limit=2&includeRelated=true&sourceDictionaries=wiktionary&useCanonical=true&includeTags=false&api_key=86454404519fadebdb90e06ef9a04381b87e620884ad40abd").read)
        results = []

        data.each{|i| results.push("%s: (%s) - %s" % [i['word'], i['partOfSpeech'], i['text']])}

        return results
      end


      def definition(m, data)
        data[0..1].each{|i| m.reply i}
      end

      match /synonym (.+)/i, method: :synonym

      def synonym(m, word)
        data = fetch_synonyms(m, word)
        list = data.join(", ")
        return m.reply Format(:red, "There are no thesaurus results for #{word}") if data.empty?
        m.reply "Here are some synonyms for #{word}: #{list}"
      end
      
      def fetch_synonyms(m, word)
        data = JSON.parse(open("http://api.wordnik.com:80/v4/word.json/#{word}/relatedWords?useCanonical=false&relationshipTypes=synonym&limitPerRelationshipType=10&api_key=86454404519fadebdb90e06ef9a04381b87e620884ad40abd").read)
        list = []
        
        for i in data
          synonym = i['words']

          list.push("%s" % [synonym])
        end
          return list
        end

      match /equivalent (.+)/i, method: :equivalent

      def equivalent(m, word)
        data = fetch_equals(m, word)
        list = data.join(", ")
        return m.reply Format(:red, "There are no equal results for #{word}") if data.empty?
        m.reply "Here are some equivalents for #{word}: #{list}"
      end

      def fetch_equals(m, word)
        data = JSON.parse(open("http://api.wordnik.com:80/v4/word.json/#{word}/relatedWords?useCanonical=true&relationshipTypes=equivalent&limitPerRelationshipType=10&api_key=86454404519fadebdb90e06ef9a04381b87e620884ad40abd").read)
        list = []
        
        for i in data
          equivalent = i['words']

          list.push("%s" % [equivalent])
        end
          return list
        end

      match /variants (.+)/i, method: :variants

      def variants(m, word)
        data = fetch_variants(m, word)
        list = data.join(", ")
        return m.reply Format(:red, "There are no variant results for #{word}") if data.empty?
        m.reply "Here are some variants of #{word}: #{list}"
      end

      def fetch_variants(m, word)
        data = JSON.parse(open("http://api.wordnik.com:80/v4/word.json/#{word}/relatedWords?useCanonical=true&relationshipTypes=variant&limitPerRelationshipType=10&api_key=86454404519fadebdb90e06ef9a04381b87e620884ad40abd").read)
        list = []
        
        for i in data
          variants = i['words']

          list.push("%s" % [variants])
        end
          return list
        end

      match /rhyme (.+)/i, method: :rhyme

      def rhyme(m, word)
        data = fetch_rhymes(m, word)
        list = data.join(", ")
        return m.reply Format(:red, "There are no rhyming results for #{word}") if data.empty?
        m.reply "Here are some words that rhyme with #{word}: #{list}"
      end

      def fetch_rhymes(m, word)
        data = JSON.parse(open("http://api.wordnik.com:80/v4/word.json/#{word}/relatedWords?useCanonical=true&relationshipTypes=rhyme&limitPerRelationshipType=20&api_key=86454404519fadebdb90e06ef9a04381b87e620884ad40abd").read)
        list = []
        
        for i in data
          rhymes = i['words']

          list.push("%s" % [rhymes])
        end
          return list
        end
      end
    end
  end    