require "json"
require "tty-prompt"

require_relative "lib/module_save.rb"
require_relative "lib/module_words.rb"
require_relative "lib/class_game.rb"
require_relative "lib/module_round.rb"

include Words
include SaveGame
include LoadGame
include DeleteSave
include Round

Debug = false

system "clear"

p "Wellcome to Hangman, insert 'new' for a fresh Game or 'load' to load a Game"
input = gets.chomp
if input.downcase == "load"
    p "insert savename"
    load_name = gets.chomp
    LoadGame.load(load_name)
else
  Round.play_round
end