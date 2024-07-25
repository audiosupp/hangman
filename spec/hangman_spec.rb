require './game'

describe Game do
  describe "#pick_random_word" do
    it "check random word" do
      game = Game.new
      expect(game.pick_random_word).not_to be_empty
      expect(game.pick_random_word).to be_an_instance_of(String)
      expect(game.pick_random_word.size).to be_between(5, 12)
    end
  end
end
