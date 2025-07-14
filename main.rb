require "json"

require_relative "lib/module_save.rb"
require_relative "lib/module_words.rb"
require_relative "lib/class_game.rb"

include Words
include SaveGame

# newsave = Words.words
# newsave = newsave.sort
# save_name = "save1.txt"
# SaveGame.save(save_name, newsave)
  
Game.get_word

until Game.win? do
  Game.get_input
  Game.compare
  Game.display_result
  Game.display_lives
end