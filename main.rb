def pick_random_word
  file = File.readlines('google-10000-english-no-swears.txt')
  word = file[rand(0..file.size)].chomp
  until word.size.between?(5, 12)
    word = file[rand(0..file.size)].chomp
  end
  word
end

p secret_word = pick_random_word


def display(secret_word, letter)
  display_word = []
  secret_word.each_char do |char|
    if char == letter
      display_word << letter
    elsif char == '*'
      display_word
    else
      display_word << '*'
    end
  end
  display_word.join
end

def string_to_hash(str)
  hash = {}
  str.each_char do |char|
    hash[char] = Array[false, char]
  end
  hash
end

secret_word_hash = string_to_hash(secret_word)
#puts secret_word_hash

incorrect_letters = []
correct_letters = []
word = []
attemps = 6
words = []
d = nil

until attemps == 0
  word = ""
  puts "write letter"
  letter = gets.chomp
  until letter.length == 1
    puts "Please enter a single character."
    letter = gets.chomp
  end

  if secret_word.include?(letter)
    puts "correct letter"
    p correct_letters << letter
  else
    puts "incorrect letter"
    p incorrect_letters << letter
    attemps -= 1
  end
  secret_word.each_char do |char|
    if correct_letters.include?(char)
      word << char
    else
      word << '_'
    end
  end
  puts word
  puts "attemps left #{attemps}"
  if word == secret_word
    puts "you win!"
    break
  end
  # word << display(secret_word, letter)
  # secret_word.each_char do |char|
  #   if char == letter
  #     d << letter
  #   else
  #     d << '*'
  #   end
  # end
  # p d
  # words << [d.join]
  # p words.select { |word| word.select { |char| char != '*' }}
end

puts "Secret word was #{secret_word}"
