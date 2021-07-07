require_relative "player"
require_relative "game"
require_relative "hero"
require_relative "group"
require_relative "villain"

archer = Archer.new(hp: 50, atk_power: 100)
spear = Spearman.new(hp: 100, atk_power: 40)
sword = Swordsman.new(hp: 75, atk_power: 75)

villains = [archer, spear, sword]

vg = VillainGroup.new(name: "ANJAY MABAR GANG", units: villains)

jin = Hero.new(name: "Jin Sakai", hp: 100, atk_power: 50, deflect_chance: 50)
game = Game.new(player1: jin, player2: vg)

game.simulate