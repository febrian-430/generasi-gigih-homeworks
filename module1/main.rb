require_relative "player"
require_relative "game"

player1 = Player.new(name: "Jin Sakai", hp: 100, atk_power: 20)
player2 = Player.new(name: "Mongol", hp: 200, atk_power: 15)

game = Game.new(player1: player1, player2: player2)

game.simulate