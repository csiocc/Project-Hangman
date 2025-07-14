require "json"

module SaveGame

  def save(save_name, save_value)
    f = File.new 'saves/tempfile', 'w'
    f.write "#{save_value}"
    f.close

    if File.exist? "saves/#{save_name}.json"
      p "Filename allready exists, try again."
    else
      File.rename 'saves/tempfile', "saves/#{save_name}.json"
      if File.exist? "saves/#{save_name}.json" #checks if save_name allready exists and return successful if yes
        puts "Save successful saved as '#{save_name}'"
      end
    end
  end
end

module LoadGame

  def load(load_name)
    if File.exist? "saves/#{load_name}.json"
      system "clear"
      p "successfully loaded #{load_name}"
      load_name = "saves/#{load_name}.json"
      load_file = File.read(load_name)
      game_instance_new = Game.from_json(load_file)
       # p "#{@lives} Lives left"
      p game_instance_new.current_word if Debug
      game_instance_new.display_result
    else
      p "Failed to load '#{load_name}' File does not exist, try again."
      p "Available Saves:"
      puts Dir["saves/*.json"]
    end
  end 
end

module DeleteSave
  def delete_save(del_name)
    p "are you sure you want to delete #{del_name} y/n"
    answer = gets.chomp
    if answer == "y" && File.exist?("saves/#{del_name}.json")
      File.delete("saves/#{del_name}.json")
      p "'#{del_name}' Successfully deleted."
    else 
    end
  end
end