# frozen_string_literal: true

require 'yaml'

# save, load or view save game files
module SaveLoadView
  def save_the_game(secret_word, correct_letters, incorrect_letters, attempts, word)
    save_dir = 'save_files'
    Dir.mkdir(save_dir) unless Dir.exist?(save_dir)
    data = {
      secret_word: secret_word,
      correct_letters: correct_letters,
      incorrect_letters: incorrect_letters,
      attempts: attempts,
      word: word
    }
    filename = "save_data_#{Time.now.strftime('%Y%m%d_%H%M%S')}.yml"
    save_path = File.join(save_dir, filename)
    File.open(save_path, 'w') do |file|
      file.write(YAML.dump(data))
    end

    puts "Data saved to: #{save_path}"
  end

  def load_game(file)
    save_dir = 'save_files'
    YAML.load_file("#{save_dir}/#{file}")
  end

  def display_saved_files
    save_dir = 'save_files'
    save_files = Dir.entries(save_dir)
    puts save_files
  end
end
