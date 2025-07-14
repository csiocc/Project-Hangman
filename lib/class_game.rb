require 'json'
require_relative 'module_words.rb'
Debug = true

class Game
  include Words
  
  def initialize # Variables for Save
    @points = 0
    @result_displ = []
    @lives = "6"
    @current_word = nil
    @input = ""
    puts "New game initialized. Welcome to Hangman! Your Word to guess will be between 5-12 Chars long."
  end
  #####################
  
  def self.get_word
    @current_word = Words.word_sample.split("")
    array = []
    @current_word.length.times do
      array.push("-")
      @result_displ = array
    end
    p @current_word if Debug
  end

  def self.display_result
    result = @result_displ.join("")
    p result
  end

  def self.get_input
    p "Type 1 Letter"
    input = gets.chomp
    @input = input
  end

  def self.compare
    temp_result = @result_displ
    @current_word.each_with_index do |word, i|  #compare each letter for match
      i += 1
      if word == @input.downcase
        temp_result[i-1] = word         #replace letter if match
        @result_displ = temp_result
      end
    end
  end

  def self.win?
    if @result_displ.include?("-")
      p "still no win"
      return false
    else return true
    end
  end

  def self.display_lives
    p "#{@lives} Lives left."
  end

end

game_one = Game.new