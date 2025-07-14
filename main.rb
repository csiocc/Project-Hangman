require 'json'
require 'tty-prompt'

require_relative 'lib/module_save'
require_relative 'lib/module_words'
require_relative 'lib/class_game'
require_relative 'lib/module_round'

include Words
include SaveGame
include LoadGame
include DeleteSave
include Round

Debug = false

system 'clear'

p "Wellcome to Hangman, insert 'new' for a fresh Game or 'load' to load a Game"
input = gets.chomp
if input.downcase == 'load'
  saves = Dir.glob('saves/*').map { |file| file[(file.index('/') + 1)...(file.index('.'))] }
  if saves.length < 1
    p "no saves found"
    return
  else
  p 'insert savename'
  puts saves
  load_name = gets.chomp
  Round.play_round(false)
  LoadGame.load(load_name)
  end
elsif input.downcase == 'exit'
  return
else
  Round.play_round(true)
  
end
