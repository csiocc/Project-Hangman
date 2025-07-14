require 'json'
require_relative 'module_words'

class String
  def bold
    "\e[1m#{self}\e[22m"
  end
end

class Game
  include Words
  attr_reader :loaded, :points
  attr_accessor :lives, :current_word, :result_displ, :new

  def initialize(points, result_displ, lives, current_word, incorrects) # Variables for Save
    @points = points
    @result_displ = result_displ
    @lives = lives
    @current_word = current_word
    @incorrects = incorrects
    @input = ''
    @new = false
    puts 'New game initialized. Welcome to Hangman! Insert ' + "'exit', 'save', 'load' or 'loadlast'".bold + 'if needed.'
    p "#{@lives} lives left."
  end
  #####################

  def to_json(*_args)
    JSON.dump({
                points: @points,
                result_displ: @result_displ,
                lives: @lives,
                current_word: @current_word,
                incorrects: @incorrects
              })
  end

  def self.from_json(string)
    data = JSON.load string
    new(data['points'], data['result_displ'], data['lives'], data['current_word'], data['incorrects'])
  end

  def self.start(_instance) # self initializer
    points = 0
    result_displ = []
    lives = 6
    current_word = nil
    incorrects = []
    Game.new(points, result_displ, lives, current_word, incorrects)
  end

  attr_reader :current_word

  def get_word
    temp_word = Words.word_sample.split('')
    @current_word = temp_word
    array = []
    @current_word.length.times do
      array.push('-')
      @result_displ = array
    end
    p "The Word to guess is #{@current_word.length} Chars long."
    display_result
    p @current_word if Debug
  end

  def display_result
    result = @result_displ.join('')
    p result
  end

  def get_input
    p 'Type 1 Char'
    input = gets.chomp
    @input = input
  end

  def compare
    temp_result = @result_displ.dup
    got_match = false
    temp_lives = @lives
    temp_points = @points.dup
    temp_incorrects = @incorrects.dup

    if @input.length > 1
      p 'invalid input, only 1 Char'
      self.display_lives
      self.display_result
      until @input.length <= 1
        input = gets.chomp
        @input = input
      end
    end

    @current_word.each_with_index do |char, i| # compare each letter for match
      if char == @input.downcase
        temp_result[i] = char # replace letter if match
        @result_displ = temp_result
        got_match = true
      end
      i + 1
    end

    if got_match
      temp_points += 2
      @points = temp_points
      p "Gotcha! +2 Points your Score is: #{@points}"
    end

    if got_match == false
      temp_incorrects.push(@input.to_s)
      @incorrects = temp_incorrects
      temp_lives -= 1
      @lives = temp_lives
    end
    puts "incorects guesses #{@incorrects}"
  end

  def win?
    p 'You loose!' if @lives == 0
    return false if @result_displ.include?('-')

    p "You Win! Your Score is: #{@points}"
    true
  end

  def display_lives
    p "#{@lives} Lives left."
  end
end
