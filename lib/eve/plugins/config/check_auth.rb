require 'cinch'
require 'yaml'

module Cinch
  module Helpers
  
    def check_auth(user)
      reload
      user.refresh
      
      return false unless !user.authname.nil?
      
      if ((@storage.key?(user.nick)) && (@storage[user.nick].key? 'auth'))
        auth = @storage[user.nick]['auth']
        return auth == user.authname
      end
    end
    
    def reload
      if File.exist?('docs/userinfo.yaml')
       @storage = YAML.load_file('docs/userinfo.yaml')
      else
        @storage = {}
      end
    end
  end
end