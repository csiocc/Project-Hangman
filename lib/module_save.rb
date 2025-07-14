

module SaveGame
  def save(save_name, save_value)
    f = File.new 'saves/tempfile', 'w'
    f.write "#{save_value}"
    f.close
    
    File.rename 'saves/tempfile', "saves/#{save_name}"
    if File.exist? "saves/#{save_name}" #checks if save_name allready exists and return successful if yes
      puts "Save successful saved as '#{save_name}'"
    end
  end
end
