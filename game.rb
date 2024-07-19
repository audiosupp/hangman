require_relative('save_load')

class Game
  include SaveLoadView

  def initialize
    @secret_word = pick_random_word
    @incorrect_letters = []
    @correct_letters = []
    @attempts = 6
    @word = ''
  end

  def pick_random_word
    file = File.readlines('google-10000-english-no-swears.txt')
    word = file[rand(0..file.size)].chomp
    word = file[rand(0..file.size)].chomp until word.size.between?(5, 12)
    word
  end

  def menu
    puts 'start game (1), load game (2), save game (3)'
    input = gets.chomp
    game_start if input == '1'
    if input == '2'
      data = game_load
      @secret_word = data[:secret_word]
      @correct_letters = data[:correct_letters]
      @incorrect_letters = data[:incorrect_letters]
      @attempts = data[:attempts]
      @word = data[:word]
      puts "game loaded.
        word: #{@word}
        correct letters: #{@correct_letters}
        incorrect letters: #{@incorrect_letters}
        attempts: #{@attempts}"
      game_start
    end
    save_the_game(@secret_word, @correct_letters, @incorrect_letters, @attempts, @word) if input == '3'
  end

  def game_load
    display_saved_files
    puts 'entry save file'
    input = gets.chomp
    load_game(input)
  end

  def game_start
    until @attempts.zero?
      puts 'write a letter (or menu for load/save a game) or (0) for exit'
      word = ''
      letter = gets.chomp

      menu if letter == 'menu'
      break if letter == '0'

      until letter.length == 1
        puts 'Please enter a single character.'
        letter = gets.chomp
      end

      if @secret_word.include?(letter)
        puts 'correct letter'
        @correct_letters << letter
      else
        puts 'incorrect letter'
        @incorrect_letters << letter
        @attempts -= 1
      end
      @secret_word.each_char do |char|
        word << if @correct_letters.include?(char)
                  char
                else
                  '_'
                end
      end

      puts word
      puts "attemps left #{@attempts}"
      puts "incorrect letters: #{@incorrect_letters.join(', ')}"
      @word = word
      if word == @secret_word
        puts 'you win!'
        puts "Secret word was #{@secret_word}"
        break
      end
      puts "Secret word was #{@secret_word}" if @attempts.zero?
    end
  end
end
