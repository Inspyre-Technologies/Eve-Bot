require 'cinch'

module Cinch::Plugins
  class FactCore
    include Cinch::Plugin
    
    set :prefix, /^~/
    set :plugin_name, 'factcore'
    set :help, <<-USAGE.gsub(/^ {6}/, '')
      Gives a funny, and sometimes true fact
      Usage:
      - ~fact: This will cause me to return with a funny (and sometimes true) fact!
      USAGE
    
    def fact(m)
      [
        Format(:green, "Fact: Space does not exist."),
        Format(:green, "The square root of rope is string."),
        Format(:green, "While the submarine is vastly superior to the boat in every way, over 97% of people still use boats for aquatic transportation."),
        Format(:green, "Cellular phones will not give you cancer. Only hepatitis."),
        Format(:green, "Pants were invented in the 16th century to avoid Poseidon's wrath. It was believed that the sight of naked sailors angered the sea god."),
        Format(:green, "The atomic weight of Germanium is 72.64."),
        Format(:green, "89% of magic tricks are not magic. Technically, they are sorcery."),
        Format(:green, "An ostrich's eye is bigger than its brain."),
        Format(:green, "In Greek myth, the craftsman Daedalus invented human flight so a group of Minotaurs would stop teasing him about it."),
        Format(:green, "Humans can survive underwater, but not for very long."),
        Format(:green, "Raseph, the Semetic god of war and plague, had a gazelle growing out of his forehead."),
        Format(:green, "The plural of Surgeon General is Surgeons General. The past tense of Surgeons General is Surgeonsed General."),
        Format(:green, "Polymerase I polypeptide A is a human gene."),
        Format(:green, "Rats cannot throw up."),
        Format(:green, "Iguanas can stay underwater for 28.7 minutes."),
        Format(:green, "Human tapeworms can grow up to 22.9 meters."),
        Format(:green, "The Schrodinger's cat paradox outlines a situation in which a cat in a box must be considered, for all intents and purposes, simultaneously alive and dead. Schrodinger created this paradox as a justification for killing cats."),
        Format(:green, "Every square inch of the human body has 32 million bacteria on it."),
        Format(:green, "The Sun is 330,330 times the size of Earth."),
        Format(:green, "The average life expectancy of a rhinoceros living in captivity is 15 years."),
        Format(:green, "Volcano-ologists are experts in the study of volcanoes."),
        Format(:green, "Avocados have the highest fiber and calories of any fruit. They are found in Australia."),
        Format(:green, "The Moon orbits the Earth every 27.32 days."),
        Format(:green, "The billionth digit of pi is nine."),
        Format(:green, "If you have trouble with simple counting, use the following mneumonic device: One, comes before two, comes before sixty, comes after twelve, comes before six-trillion, comes after five-hundred-and-four. This will make your earlier counting difficulties seem like no big deal."),
        Format(:green, "A gallon of water weighs 8.34 pounds."),
        Format(:green, "Hot water freezes quicker than cold water."),
        Format(:green, "Honey does not spoil."),
        Format(:green, "The average adult human body contains half a pound of salt."),
        Format(:green, "A nanosecond lasts one-billionth of a second."),
        Format(:green, "According to Norse legend, thunder god Thor's chariot was pulled across the sky by two goats."),
        Format(:green, "China produces the world's second largest crop of soybeans."),
        Format(:green, "Tungsten has the highest melting point of any metal, at 3,410 degrees Celsius."),
        Format(:green, "Gently cleaning the tongue twice a day is the most effective way to fight bad breath."),
        Format(:green, "Roman toothpaste was made with urine. Urine is an ingredient in toothpaste continued to be used up until the 18th century."),
        Format(:green, "The Tariff Act of 1789, established to protect domestic manufacture, was the second statute ever enacted by the United States government."),
        Format(:green, "The value of Pi is the ratio of any circle's circumference to its diameter in Euclidean space."),
        Format(:green, "The Mexican-American War ended in 1838 with the signing of the Treaty of Guadelupe Hidalgo."),
        Format(:green, "In 1879, Sandford Fleming first produced the adoption of worldwide standardized time zones at the Royal Canadian Institute."),
        Format(:green, "Marie Curie invented the theory of radioactivity, the treatment of radioactivity, and dying of radioactivity."),
        Format(:green, "At the end of The Seagull by Anton Chekhov, Konstantin kills himself."),
        Format(:green, "Contrary to popular belief, the Eskimo does not have 100 different words for snow. They do, however, have 234 words for fudge."),
        Format(:green, "In Victorian England, a commoner was not allowed to look directly at the Queen, due to a belief at the time that the poor had the ability to steal thoughts. Science now believes that less than 4% of poor people are able to do this."),
        Format(:green, "In 1862, Abraham Lincoln signed the Emancipation Proclamation, freeing the slaves. Like everything he did, Lincoln freed the slaves while sleepwalking, and later had no memory of the event."),
        Format(:green, "In 1948, at the request of a dying boy, baseball legend Babe Ruth at 75 hot dogs, then died of hot dog poisoning."),
        Format(:green, "William Shakespeare did not exist. His plays were masterminded in 1589 by Francis Bacon, who used a Ouiji board to enslave playwriting ghosts."),
        Format(:green, "It is incorrectly noted that Thomas Edison invented push-ups in 1878. Nikolai Tesla had in fact patented the activity three years earlier, under the name Tesla-cize."),
        Format(:green, "Whales are twice as intelligent and three times as delicious as humans."),
        Format(:green, "The automobile brake was not invented until 1895. Before this, someone had to be in the car at all times, driving in circles until passengers returned from their errands."),
        Format(:green, "Edmund Hilary, the first person to climb Mt. Everest, did so accidentally, while chasing a bird."),
        Format(:green, "Diamonds are made when coal is put under intense pressure. Diamonds put under intense pressure become foam pellets, commonly used today as packing material."),
        Format(:green, "The most poisonous fish in the world is the orange ruffy. Everything on its body is made of a deadly poison. The ruffy's eyes are composed of a less harmful deadly poison."),
        Format(:green, "The occupation of court jester was invented accidentally, when a vassal's epilepsy was mistaken for capering."),
        Format(:green, "Halley's Comet can be viewed orbiting Earth every seventy-six years. For the other seventy-five, it retreats to the heart of the Sun, where it hibernates undisturbed."),
        Format(:green, "The first commercial air flight took place in 1914. Everyone involved screamed the entire way."),
        Format(:green, "In Greek myth, Prometheus stole fire from the gods and gave it to humankind. The jewellery he kept for himself."),
        Format(:green, "The first person to prove that cow's milk is drinkable was very, very thirsty."),
        Format(:green, "Before the Wright Brothers invented the airplane, anyone wanting to fly anywhere was required to eat 200 pounds of helium."),
        Format(:green, "Before the invention of scrambled eggs in 1912, the typical breakfast was either whole eggs still in the shell, or scrambled rocks."),
        Format(:green, "During the Great Depression, the Tennessee Valley Authority outlawed pet rabbits, forcing many to hot glue-gun long ears onto their pet mice."),
        Format(:green, "At some point in their lives 1 in 6 children will be abducted by the Dutch."),
        Format(:green, "According to most advanced algorithms, the world's best name is Craig."),
        Format(:green, "To make a photocopier, simply photocopy a mirror."),
        Format(:green, "Dreams are the subconscious mind's way of reminding people to go to school naked and have their teeth fall out.")
      ].sample
    end
      
    match /fact/, method: :execute_fact
    
    def execute_fact(m)
      m.reply fact(m)
    end
  end
end

# EVE is a project for a Top-Tier IRC bot, and the project could always use more help.
# Feel free to contribute at the github:  https://github.com/Namasteh/Eve-Bot
# For help with the Cinch framework you can always visit #Cinch at irc.freenode.net
# For help with EVE you can always visit #Eve at rawr.sinsira.net        
        
