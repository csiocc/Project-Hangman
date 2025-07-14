

module Round
  
  def play_round(loaded)
    game_instance = Game.start(game_instance)
    game_instance.get_word if loaded

    until game_instance.win? || game_instance.lives == 0

      save_value = game_instance.to_json
      input = game_instance.get_input

      if  input == 'exit'
        p 'Exiting, cu!'
        break
      elsif input == 'save'
        p 'input Savename'
        save_name_input = gets.chomp
        save_name = "#{save_name_input}"
        SaveGame.save(save_name, save_value)
      elsif input == 'loadlast'
        load_name = save_name
        LoadGame.load(load_name)
      elsif input == 'load'
        system 'clear'
        saves = Dir.glob('saves/*').map { |file| file[(file.index('/') + 1)...(file.index('.'))] }
        p 'insert savename'
        puts saves
        load_name = gets.chomp
        LoadGame.load(load_name)
      elsif input == 'delete'
        system 'clear'
        p 'insert the savename to delete'
        del_name = gets.chomp
        DeleteSave.delete_save(del_name)

      else
        system 'clear'

        game_instance.compare
        p "Points: #{game_instance.points}"
        game_instance.display_result
        game_instance.display_lives
      end
    end
  end
end
