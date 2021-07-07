require_relative "player"
require_relative "game"
require_relative "hero"
require_relative "archer"
require_relative "spearman"
require_relative "swordsman"


jin = Hero.new(name: "Jin Sakai", hp: 100, atk_power: 50, deflect_chance: 80)
yuna = Player.new(name: "Yuna", hp: 90, atk_power: 45)
ishikawa = Player.new(name: "Sensei Ishikawa", hp: 80, atk_power: 60)


archer = Archer.new(hp: 80, atk_power: 40)
spearman = Spearman.new(hp: 120, atk_power: 60)
swordsman = Swordsman.new(hp: 100, atk_power: 50)

villains = [archer, spearman, swordsman]
allies = [jin, yuna, ishikawa]

game = Game.new(group1: allies, group2: villains)

game.simulate