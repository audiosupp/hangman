require 'yaml'

def pick_random_word
  file = File.readlines('google-10000-english-no-swears.txt')
  word = file[rand(0..file.size)].chomp
  until word.size.between?(5, 12)
    word = file[rand(0..file.size)].chomp
  end
  word
end

def save_the_game(secret_word, correct_letters, incorrect_letters, attempts)
  save_dir = "save_files"
  Dir.mkdir(save_dir) unless Dir.exist?(save_dir)
  data = {
  secret_word: secret_word,
  correct_letters: correct_letters,
  incorrect_letters: incorrect_letters,
  attempts: attempts
  }
  p data
  filename = "save_data_#{Time.now.strftime('%Y%m%d_%H%M%S')}.yml"
  save_path = File.join(save_dir, filename)
  File.open(save_path, "w") do |file|
    file.write(YAML.dump(data))
  end

  puts "Data saved to: #{save_path}"
end

def load_game(file)
  save_dir = "save_files"
  data = YAML.load_file("#{save_dir}/#{file}")
end

def display_saved_files
  save_dir = "save_files"
  save_files = Dir.entries(save_dir)
  puts save_files
end


p secret_word = pick_random_word

incorrect_letters = []
correct_letters = []
attempts = 6


until attempts.zero?
  word = ""
  puts "write letter or save the game? (2) or load game (1)"
  letter = gets.chomp
  if letter == "1"
    display_saved_files
    puts "entry save file"
    input = gets.chomp
    data = load_game(input)
    secret_word = data[:secret_word]
    correct_letters = data[:correct_letters]
    incorrect_letters = data[:incorrect_letters]
    attempts = data[:attempts]
    # count as attempt, fix that
  end
  if letter == "2"
    save_the_game(secret_word, correct_letters, incorrect_letters, attempts)
    break
  end
  until letter.length == 1
    puts "Please enter a single character."
    letter = gets.chomp
  end

  if secret_word.include?(letter)
    puts "correct letter"
    correct_letters << letter
  else
    puts "incorrect letter"
    incorrect_letters << letter
    attempts -= 1
  end
  secret_word.each_char do |char|
    if correct_letters.include?(char)
      word << char
    else
      word << '_'
    end
  end

  puts word
  puts "attemps left #{attempts}"
  puts "incorrect letters: #{incorrect_letters.join(', ')}"
  if word == secret_word
    puts "you win!"
    puts "Secret word was #{secret_word}"
    break
  end
  if attempts.zero?
    puts "Secret word was #{secret_word}"
  end
end
