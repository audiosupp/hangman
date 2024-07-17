def pick_random_word
  file = File.readlines('google-10000-english-no-swears.txt')
  word = file[rand(0..file.size)].chomp
  until word.size.between?(5, 12)
    word = file[rand(0..file.size)].chomp
  end
  word
end

p secret_word = pick_random_word


incorrect_letters = []
correct_letters = []
attemps = 6


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
    correct_letters << letter
  else
    puts "incorrect letter"
    incorrect_letters << letter
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
  puts "incorrect letters: #{incorrect_letters.join(', ')}"
  if word == secret_word
    puts "you win!"
    break
  end
end

puts "Secret word was #{secret_word}"
