require_relative "player"
require_relative "game"
require_relative "hero"

jin = Hero.new(name: "Jin Sakai", hp: 100, atk_power: 20)
mongol = Player.new(name: "Mongol", hp: 200, atk_power: 15)

game = Game.new(player1: jin, player2: mongol)

game.simulate