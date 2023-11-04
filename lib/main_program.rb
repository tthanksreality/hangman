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

murtveca = Word.new('../google-10000')
p murtveca.select_word