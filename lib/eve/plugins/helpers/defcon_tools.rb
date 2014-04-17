require 'cinch'

module Cinch
  module Helpers
    
    def d_limit(m, chan, option)
      if option == "on"
	@limit = option == "on"
	count = Channel(chan).users.count.to_i
	count = count + 2
	User("ChanServ").send("set #{chan} MLOCK +ntsl #{count}")
	return
      end
	if option == "off"
	  @limit = option == "off"
	  User("ChanServ").send("set #{chan} MLOCK +nt-sl")
	  return
	end
      end
  end
end