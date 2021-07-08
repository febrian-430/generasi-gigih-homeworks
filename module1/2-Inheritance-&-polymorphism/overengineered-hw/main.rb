require_relative "player"
require_relative "game"
require_relative "hero"
require_relative "group"
require_relative "villain_group"
require_relative "villain"
require_relative "archer"
require_relative "spearman"
require_relative "swordsman"


archer = Archer.new(hp: 50, atk_power: 100)
spear = Spearman.new(hp: 100, atk_power: 40)
sword = Swordsman.new(hp: 75, atk_power: 75)

jin = Hero.new(name: "Jin Sakai", hp: 100, atk_power: 50, deflect_chance: 80)
yuna = Player.new(name: "Yuna", hp: 90, atk_power: 45)
ishikawa = Player.new(name: "Sensei Ishikawa", hp: 80, atk_power: 60)

villains = [archer, spear, sword]

vg = VillainGroup.new(name: "Mongols", units: villains)

jin_members = [jin, yuna, ishikawa]
jin_party = Group.new(name: "Jin Sakai party", units: jin_members)
game = Game.new(player1: jin_party, player2: vg)

game.simulate