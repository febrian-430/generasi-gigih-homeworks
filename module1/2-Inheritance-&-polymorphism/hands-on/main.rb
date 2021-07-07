require_relative "player"
require_relative "game"
require_relative "hero"

jin = Hero.new(name: "Jin Sakai", hp: 100, atk_power: 50, deflect_chance: 80)
mongol = Player.new(name: "Mongol", hp: 500, atk_power: 50)

game = Game.new(player1: jin, player2: mongol)

game.simulate