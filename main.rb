require "json"
require "tty-prompt"

require_relative "lib/module_save.rb"
require_relative "lib/module_words.rb"
require_relative "lib/class_game.rb"

include Words
include SaveGame
include LoadGame
include DeleteSave

Debug = false

system "clear"

class String
    def bold
        "\e[1m#{self}\e[22m" 
    end
end


game_instance = Game.start(game_instance)
game_instance.get_word


until game_instance.win? || game_instance.lives == 0 do

  save_value = game_instance.to_json
  input = game_instance.get_input

  if  input == "exit"
    p "Exiting, cu!"
    break
  elsif input == "save"
    p "input Savename"
    save_name_input = gets.chomp
    save_name = "#{save_name_input}"
    SaveGame.save(save_name, save_value)
  elsif input == "loadlast"
    load_name = save_name
    LoadGame.load(load_name)
  elsif input == "load"
    system "clear"
    p "insert savename"
    load_name = gets.chomp
    LoadGame.load(load_name)
  elsif input == "delete"
    system "clear"
    p "insert the savename to delete"
    del_name = gets.chomp
    DeleteSave.delete_save(del_name)

  else
    system "clear"
    
    game_instance.compare
    p "Points: #{game_instance.points}"
    game_instance.display_result
    game_instance.display_lives
  end
end