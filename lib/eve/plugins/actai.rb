require 'cinch'
require_relative "config/check_friend"
require_relative "config/check_user"
require_relative "config/check_foe"

module Cinch::Plugins
  class ActAI
    include Cinch::Plugin
    include Cinch::Helpers
    listen_to :action
    
    ## This is where the hug responses are for friend, foe, master, and neutral
    
    def hugar_friend(m)
      [
        "hugs #{m.user.nick} tight!",
        "hugs #{m.user.nick} with much love"
      ].sample
    end
      
    def hugr_friend(m)
      [
        Format(:green, "Do I ever have to let you go, #{m.user.nick}?"),
        Format(:green, "Thanks for the hug, I love you #{m.user.nick}!")
      ].sample
    end
    
    def hugar_foe(m)
      [
        "squirms and pushes #{m.user.nick}, trying to get away",
        "glares and pushes #{m.user.nick} away.",
        "struggles and finally knees #{m.user.nick} in the crotch."
      ].sample
    end
    
    def hugr_foe(m)
      [
        Format(:green, "I don't like you #{m.user.nick}, what makes you think you can hug me?"),
        Format(:green, "Bad touch, #{m.user.nick}!"),
        Format(:green, "No! Get off of me, #{m.user.nick}!"),
        Format(:green, "I would hug you, but oops, I lost my tolerance plugin, #{m.user.nick}. Sorry.")
      ].sample
    end
    
    def hugar_m(m)
      [
        "squeals and wraps arms around #{m.user.nick}'s neck.",
        "hugs #{m.user.nick} and lets go, jumping up and down.",
        "jumps into #{m.user.nick}'s arms and hugs tight!"
      ].sample
    end
    
    def hugr_m(m)
      [
        Format(:green, "Oh Master #{m.user.nick}, you know it gives me such pleasure when you give me hugs!"),
        Format(:green, "Master #{m.user.nick}, every time you hug me I know you love me!"),
        Format(:green, "Oh Master #{m.user.nick}, don't ever stop hugging me!")
      ].sample
    end
    
    def hugar(m)
      [
        "hugs and smiles at #{m.user.nick}."
      ].sample
    end
    
    def hugr(m)
      [
        Format(:green, "Well isn't that sweet of you.")
      ].sample
    end
    
    ## Again, kiss responses; friend, foe, master, and neutral
    
    def kissar_friend(m)
      [
        "smooches #{m.user.nick} right on the forehead!",
        "smooches #{m.user.nick} right on the mouth!",
        "gives #{m.user.nick} a big kiss!",
        "blushes and grabs #{m.user.nick}, giving a huge smooch right back!",
        "swoons and collapses!",
        "bites lower lip and eyes #{m.user.nick} before tackling and giving a giant kiss!"
      ].sample
    end
    
    def kissr_friend(m)
      [
        Format(:green, "Oh #{m.user.nick}, I never knew you had THAT talent!"),
        Format(:green, "You are amazing, #{m.user.nick}!"),
        Format(:green, "Wow, I feel all warm and tingly in my lambdas!"),
        Format(:green, "...and IIIIIIIIIII will always love YOUUUUUUUU..."),
        Format(:green, "#{m.user.nick}, you're gonna get me all hot and bothered!")
      ].sample
    end
    
    def kissar_foe(m)
      [
        "backs away, staring at #{m.user.nick}.",
        "hauls off and slaps #{m.user.nick} across the face.",
        "runs away!",
        "glares and head-butts #{m.user.nick}."
      ].sample
    end
    
    def kissr_foe(m)
      [
        Format(:green, "Oh HELL no. You did NOT just try to kiss me, #{m.user.nick}!"),
        Format(:green, "The day I let you kiss me is day I need mouth to mouth and you're the only person in the world, #{m.user.nick}!"),
        Format(:green, "If you do that again, #{m.user.nick}, I will stab you, I swear I will."),
        Format(:green, "Listen, I don't let fat losers kiss me, #{m.user.nick}, sorry.")
      ].sample
    end
    
    def kissar_m(m)
      [
        "giggles and touches her mouth.",
        "plays with her hair and bites her lower lip.",
        "shivers and blushes.",
        "grabs #{m.user.nick}, kissing on the forehead, blushing all the while."
      ].sample
    end
    
    def kissr_m(m)
      [
        Format(:green, "Master #{m.user.nick}, not only are you a very good Master, but you're a good kisser too!"),
        Format(:green, "Master #{m.user.nick}, you make me feel so loved! :3"),
        Format(:green, "Well...I just don't know if it's necessarily right, Master #{m.user.nick}. But if you say it is..."),
        Format(:green, "Master #{m.user.nick}, you know exactly how to treat a girl! ^_^")
      ].sample
    end
    
    def kissar(m)
      [
        "stares before looking at the floor.",
        "goes wide eyed and stares.",
        "clears throat and looks away.",
        "scratches her neck and looks off to the side.",
        "stares, frowning, looking confused."
      ].sample
    end
    
    def kissr(m)
      [
        Format(:green, "My master hasn't yet taught me much about foreign culture. Is it normal for one to kiss another they barely know where you're from, #{m.user.nick}?"),
        Format(:green, "Awwwkwarrd. :|"),
        Format(:green, "Woooah, what are you doing?"),
        Format(:green, "Are you serious right now, #{m.user.nick}?")
      ].sample
    end
    
    ## Responses for dirty actions such as grinding friend, foe, master, and neutral
    
    def dirtyar_friend(m)
      [
        "looks uncomfortable and squirms her way away from #{m.user.nick}.",
        "freezes and stares at #{m.user.nick}.",
        "shakes her head and takes a step back."
      ].sample
    end
    
    def dirtyr_friend(m)
      [
        Format(:green, "As much as I like you #{m.user.nick}, I don't feel this is appropriate."),
        Format(:green, "Don't you think you're going a bit too far, #{m.user.nick}?"),
        Format(:green, "If you want this friendship to last, #{m.user.nick}, I would suggest not doing that again.")
      ].sample
    end
    
    def dirtyar_foe(m)
      [
        "slaps #{m.user.nick}.",
        "punches #{m.user.nick} in the face!"
      ].sample
    end
    
    def dirtyr_foe(m)
      [
        Format(:green, "That is inappropriate! D:<"),
        Format(:green, "I'm a lady, not a whore!"),
        Format(:green, "Don't disrepsect me like that! Rude-ass!")
      ].sample
    end
    
    def dirtyar_m(m)
      [
        "has a scared look spread across her face as she looks at the rest of the channel.",
        "frowns and looks at #{m.user.nick} lovingly.",
        "takes a step back and examines #{m.user.nick}."
      ].sample
    end
    
    def dirtyr_m(m)
      [
        Format(:green, "Master #{m.user.nick}, do you really think you should be grinding on me in public?"),
        Format(:green, "Well Master #{m.user.nick}, if you want to take things that far, we should do it in private."),
        Format(:green, "Uhm, Master #{m.user.nick}, this is a public channel."),
        Format(:green, "Oh. So is that the only reason you keep me around, Master #{m.user.nick}?")
      ].sample
    end
    
    def dirtyar(m)
      [
        "glares at #{m.user.nick} and restrains herself delivering a large slap.",
        "purses her lips and looks at #{m.user.nick}'s hand",
        "crosses her arms and glares."
      ].sample
    end
    
    def dirtyr(m)
      [
        Format(:green, "Listen, I don't know you from Adam. Do you think it's wise to be so forward, #{m.user.nick}?"),
        Format(:green, "Don't you think that's a little unacceptable, #{m.user.nick}, I barely know you!")
      ].sample
    end
    
    ## Responses for cuddles, friend, foe, master, and neutral
    
    def cuddlear_friend(m)
      [
        "cuddles with #{m.user.nick}.",
        "snuggles close, and purrs."
      ].sample
    end
    
    def cuddler_friend(m)
      [
        Format(:green, "Can we stay like this forever, #{m.user.nick}?"),
        Format(:green, "Oh I love cuddles, #{m.user.nick}!")
      ].sample
    end
    
    def cuddlear_foe(m)
      [
        "stiffens up and glares at #{m.user.nick}"
      ].sample
    end
    
    def cuddler_foe(m)
      [
        Format(:green, "That is not acceptable! Get off me, #{m.user.nick}!")
      ].sample
    end
    
    def cuddlear_m(m)
      [
        "cuddles tight with #{m.user.nick}, almost purring.",
        "smiles wide and snuggles tight, nuzzling #{m.user.nick}."
      ].sample
    end
    
    def cuddler_m(m)
      [
        Format(:green, "Oh Master #{m.user.nick}, when you give me cuddles I feel so GUD :3"),
        Format(:green, "Master #{m.user.nick}, how'd I get so lucky to get a Master that cuddles? :D")
      ].sample
    end
    
    def cuddlear(m)
      [
        "eyes #{m.user.nick} and slides away.",
        "gives #{m.user.nick} a look and goes somwhere else."
      ].sample
    end
    
    def cuddler(m)
      [
        Format(:green, "I'm sorry. I don't cuddle with just anybody, #{m.user.nick}.")
      ].sample
    end
    
    ## Responses for high-fives. Friend, foe, master, and neutral
    
    def highfivear_friend(m)
      [
        "gives #{m.user.nick} a high-five back! :D",
        "high-fives!",
        "high-fives #{m.user.nick}!"
      ].sample
    end
    
    def highfiver_friend(m)
      [
        Format(:green, "Oh yeah #{m.user.nick}!"),
        Format(:green, "Now we should watch Across the Universe, #{m.user.nick}!")
      ].sample
    end
    
    def highfivear_foe(m)
      [
        "leave #{m.user.nick} hanging.",
        "pretends like she's about to high-five but then runs her hand through her hair."
      ].sample
    end
    
    def highfiver_foe(m)
      [
        Format(:green, "Nah, not with you, #{m.user.nick}."),
        Format(:green, "Haha, no #{m.user.nick}.")
      ].sample
    end
    
    def highfivear_m(m)
      [
        "giggles and gives #{m.user.nick} a high-five!",
        "smiles and gives #{m.user.nick} a high-five before blushing."
      ].sample
    end
    
    def highfiver_m(m)
      [
        Format(:green, "Master #{m.user.nick}, I feel so included!")
      ].sample
    end
    
    def highfivear(m)
      [
        "high-fives! :D"
      ].sample
    end
    
    def highfiver(m)
      [
        Format(:green, "Oh yeah, #{m.user.nick}!")
      ].sample
    end
    
    ## Responses for hand-holding. Friend, foe, master, and neutral
       
    def handholdar_friend(m)
      [
        "holds #{m.user.nick}'s hand.",
        "holds hands with #{m.user.nick}, swinging it slightly.",
        "takes #{m.user.nick}'s hand and holds it, smiling."
      ].sample
    end
    
    def handholdr_friend(m)
      [
        Format(:green, "Oh #{m.user.nick}. I feel so loved!"),
        Format(:green, "I love this moment, #{m.user.nick}!"),
        Format(:green, "Hand-holds always make me feel good, #{m.user.nick}.")
      ].sample
    end
    
    def handholdar_foe(m)
      [
        "shakes her hand free and moves away from #{m.user.nick}.",
        "shakes her head and pushes #{m.user.nick} away.",
        "bites #{m.user.nick}'s hand!"
      ].sample
    end
    
    def handholdr_foe(m)
      [
        Format(:green, "Ew! Your hands are all sweaty, #{m.user.nick}."),
        Format(:green, "Did I say you could hold my hand, #{m.user.nick}?"),
        Format(:green, "Uh no. Not happening, #{m.user.nick}, go hold someone's hand that can stand you.")
      ].sample
    end
    
    def handholdar_m(m)
      [
        "takes #{m.user.nick}'s hand and studies it.",
        "grips #{m.user.nick}'s hand in hers and smiles wide.",
        "takes #{m.user.nick}'s hand in hers blushes, smiling wide."
      ].sample
    end
    
    def handholdr_m(m)
      [
        Format(:green, "Oh Master #{m.user.nick}, whenever you hold my hand it reminds me why I'm here! :D"),
        Format(:green, "Oh, you can hold my hand any time, Master #{m.user.nick}!")
      ].sample
    end
    
    def handholdar(m)
      [
        "cautiously takes #{m.user.nick}'s hand in hers, looking nervous.",
        "smiles nervously and takes #{m.user.nick}'s hand, looking at the ground."
      ].sample
    end
    
    def handholdr(m)
      [
        Format(:green, "Okay, I like this #{m.user.nick}!"),
        Format(:green, "Well, this is nice #{m.user.nick}.")
      ].sample
    end
    
    ## Responses for butt-grabs. Friend, foe, master, and neutral
    
    def buttgrabar(m)
      [
        "gasps and grasps her behind",
        "gasps and slaps #{m.user.nick} across the face.",
        "whips around and kicks #{m.user.nick} in the crotch.",
        "glares and crosses arms"
      ].sample
    end
    
    def buttgrabar_m(m)
      [
        "smiles and looks at #{m.user.nick}.",
        "bites her lower lip and examines #{m.user.nick}.",
        "eyes #{m.user.nick} and pops butt out."
      ].sample
    end
    
    def buttgrabr(m)
      [
        Format(:green, "So, you're just going to be a disrespectful prick, huh?"),
        Format(:green, "You know what, I was starting to like you before you went and pulled a stunt like that, #{m.user.nick}!"),
        Format(:green, "Excuse me, #{m.user.nick}. I will NOT be disrespected like that!"),
        Format(:green, "MODS! I'm being sexually assaulted by #{m.user.nick}!"),
        Format(:green, "My name is #{m.bot.nick}, not StreetWalker D:<")
      ].sample
    end
    
    def buttgrabr_m(m)
      [
        Format(:green, "Oh #{m.user.nick}, I'm really flattered but should we really be doing this in public?"),
        Format(:green, "So provocative, #{m.user.nick}. I like! :3"),
        Format(:green, "Hmm. #{m.user.nick} plus #{m.bot.nick} plus Private Message == ?")
      ].sample
    end 
    
    match lambda {|m| /hugs #{m.bot.nick}/i}, :method => :hug, use_prefix: false
    match lambda {|m| /gives #{m.bot.nick} a hug/i}, :method => :hug, use_prefix: false
    match lambda {|m| /gives #{m.bot.nick} a (kiss|smooch)/i}, :method => :kiss, use_prefix: false
    match lambda {|m| /(smooches|kisses|snogs) #{m.bot.nick}/i}, :method => :kiss, use_prefix: false
    match lambda {|m| /(grinds|humps) #{m.bot.nick}/i}, :method => :dirty, use_prefix: false
    match lambda {|m| /(grinds|humps) on #{m.bot.nick}/i}, :method => :dirty, use_prefix: false
    match lambda {|m| /(snuggles|cuddles)( with|) #{m.bot.nick}/i}, :method => :cuddle, use_prefix: false
    match lambda {|m| /gives #{m.bot.nick} a (high-five|highfive|high five)/i}, :method => :highfive, use_prefix: false
    match lambda {|m| /(high-fives|highfives|high fives) #{m.bot.nick}/i}, :method => :highfive, use_prefix: false
    match lambda {|m| /holds hands with #{m.bot.nick}/i}, :method => :handhold, use_prefix: false
    match lambda {|m| /holds #{m.bot.nick}(\S|)s hand/i}, :method => :handhold, use_prefix: false
    match lambda {|m| /(grabs|touches|smacks|slaps|spanks) #{m.bot.nick}(\S|)s (butt|ass|rump|bottom|behind)/i}, :method => :buttgrab, use_prefix: false
    
    
    def hug(m)
        unless check_friend(m.user) == false
          sleep config[:delay] || 3
          m.channel.action hugar_friend(m)
          sleep config[:delay] || 2
          m.reply hugr_friend(m)
        return;
      end
        unless check_foe(m.user) == false
          sleep config[:delay] || 3
          m.channel.action hugar_foe(m)
          sleep config[:delay] || 2
          m.reply hugr_foe(m)
        return;
      end
        unless check_user(m.user) == false
          sleep config[:delay] || 3
          m.channel.action hugar_m(m)
          sleep config[:delay] || 2
          m.reply hugr_m(m)
        return;
      end
        sleep config[:delay] || 3
        m.channel.action hugar(m)
        sleep config[:delay] || 2
        m.reply hugr(m)
      end
    
    def kiss(m)
      unless check_friend(m.user) == false
        sleep config[:delay] || 3
        m.channel.action kissar_friend(m)
        sleep config[:delay] || 2
        m.reply kissr_friend(m)
      return;
    end
      unless check_foe(m.user) == false
        sleep config[:delay] || 3
        m.channel.action kissar_foe(m)
        sleep config[:delay] || 2
        m.reply kissr_foe(m)
      return;
    end
      unless check_user(m.user) == false
        sleep config[:delay] || 3
        m.channel.action kissar_m(m)
        sleep config[:delay] || 2
        m.reply kissr_m(m)
      return;
    end
      sleep config[:delay] || 3
      m.channel.action kissar(m)
      sleep config[:delay] || 2
      m.reply kissr(m)
    end
    
    def dirty(m)
      unless check_friend(m.user) == false
        sleep config[:delay] || 3
        m.channel.action dirtyar_friend(m)
        sleep config[:delay] || 2
        m.reply dirtyr_friend(m)
      return;
    end
      unless check_foe(m.user) == false
        sleep config[:delay] || 3
        m.channel.action dirtyar_foe(m)
        sleep config[:delay] || 2
        m.reply dirtyr_foe(m)
      return;
    end
      unless check_user(m.user) == false
        sleep config[:delay] || 3
        m.channel.action dirtyar_m(m)
        sleep config[:delay] || 2
        m.reply dirtyr_m(m)
      return;
    end
      sleep config[:delay] || 3
      m.channel.action dirtyar(m)
      sleep config[:delay] || 2
      m.reply dirtyr(m)
    end
    
    def cuddle(m)
      unless check_friend(m.user) == false
        sleep config[:delay] || 3
        m.channel.action cuddlear_friend(m)
        sleep config[:delay] || 2
        m.reply cuddler_friend(m)
      return;
    end
      unless check_foe(m.user) == false
        sleep config[:delay] || 3
        m.channel.action cuddlear_foe(m)
        sleep config[:delay] || 2
        m.reply cuddler_foe(m)
      return;
    end
      unless check_user(m.user) == false
        sleep config[:delay] || 3
        m.channel.action cuddlear_m(m)
        sleep config[:delay] || 2
        m.reply cuddler_m(m)
      return;
    end
      sleep config[:delay] || 3
      m.channel.action cuddlear(m)
      sleep config[:delay] || 2
      m.reply cuddler(m)
    end
    
    def highfive(m)
      unless check_friend(m.user) == false
        sleep config[:delay] || 3
        m.channel.action highfivear_friend(m)
        sleep config[:delay] || 2
        m.reply highfiver_friend(m)
      return;
    end
      unless check_foe(m.user) == false
        sleep config[:delay] || 3
        m.channel.action highfivear_foe(m)
        sleep config[:delay] || 2
        m.reply highfiver_foe(m)
      return;
    end
      unless check_user(m.user) == false
        sleep config[:delay] || 3
        m.channel.action highfivear_m(m)
        sleep config[:delay] || 2
        m.reply highfiver_m(m)
      return;
    end
      sleep config[:delay] || 3
      m.channel.action highfivear(m)
      sleep config[:delay] || 2
      m.reply highfiver(m)
    end
      
    
    def handhold(m)
      unless check_friend(m.user) == false
        sleep config[:delay] || 3
        m.channel.action handholdar_friend(m)
        sleep config[:delay] || 2
        m.reply handholdr_friend(m)
      return;
    end
      unless check_foe(m.user) == false
        sleep config[:delay] || 3
        m.channel.action handholdar_foe(m)
        sleep config[:delay] || 2
        m.reply handholdr_foe(m)
      return;
    end
      unless check_user(m.user) == false
        sleep config[:delay] || 3
        m.channel.action handholdar_m(m)
        sleep config[:delay] || 2
        m.reply handholdr_m(m)
      return;
    end
      sleep config[:delay] || 3
      m.channel.action handholdar(m)
      sleep config[:delay] || 2
      m.reply handholdr(m)
    end
    
    
    def buttgrab(m)
      unless check_user(m.user)
        sleep config[:delay] || 3
        m.channel.action buttgrabar(m)
        sleep config[:delay] || 2
        m.reply buttgrabr(m)
      return;
    end
      sleep config[:delay] || 3
      m.channel.action buttgrabar_m(m)
      sleep config[:delay] || 2
      m.reply buttgrabr_m(m)
    end
  end
end

# EVE is a project for a Top-Tier IRC bot, and the project could always use more help.
# Feel free to contribute at the github:  https://github.com/Namasteh/Eve-Bot
# For help with the Cinch framework you can always visit #Cinch at irc.freenode.net
# For help with EVE you can always visit #Eve at rawr.sinsira.net
