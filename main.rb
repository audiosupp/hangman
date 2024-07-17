def pick_random_word
  file = File.readlines('google-10000-english-no-swears.txt')
  word = file[rand(0..file.size)].chomp
  until word.size.between?(5, 12)
    word = file[rand(0..file.size)].chomp
  end
  word
end

p secret_word = pick_random_word
