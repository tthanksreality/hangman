# frozen_string_literal: true

puts 'Let the game of hangman begin!'

## Recieves a random word between 5 and 12 characters from file
class Word
  attr_reader :random_word

  def initialize(path)
    @path = path
    @random_word = select_word
  end

  def select_word
    file = File.open(@path)
    lines = file.read.split("\n")
    selected_words = lines.select { |word| word.length.between?(5, 12) }
    selected_words.sample
  end
end

## Allows the player to guess the word
class Guess
  def initialize
    @word = Word.new('../google-10000')
    @board = @word.select_word
    @guessed_word = '*' * @board.length
  end

  def show_word
    @board
  end

  def check_win
    if @guessed_word.include?('*')
      puts "You are out of turns! The word was #{@board}."
    else
      puts "You guessed the word! It was: #{@guessed_word}!"
    end
  end

  def play(secret_word)
    turns_remaining = 8
    while turns_remaining.positive? && @guessed_word.include?('*')
      puts "Word: #{@guessed_word}"
      print "Turns remaining: #{turns_remaining}. Please enter your guess:"
      guess = gets.chomp.downcase
      if secret_word == guess
        puts "Congrats, you got the word! It was #{@board}" 
        return
      end
      if secret_word.include?(guess)
        secret_word.chars.each_with_index do |char, index|
          @guessed_word[index] = char if char == guess
        end
      else
        turns_remaining -= 1
      end
    end
    check_win
  end
end

game = Guess.new
game.play(game.show_word)
