require_relative "game"
require "./person/player.rb"
require "./person/hero.rb"
require "./person/villain.rb"
require "./person/archer.rb"
require "./person/spearman.rb"
require "./person/swordsman.rb"
require "./person/playable.rb"
require  "./group/playable_group.rb"
require  "./group/villain_group.rb"


archer = Archer.new(hp: 50, atk_power: 100)
spear = Spearman.new(hp: 100, atk_power: 40)
sword = Swordsman.new(hp: 75, atk_power: 75)

jin = Hero.new(name: "Jin Sakai", hp: 1, atk_power: 50, deflect_chance: 0)
yuna = Player.new(name: "Yuna", hp: 90, atk_power: 45)
ishikawa = Player.new(name: "Sensei Ishikawa", hp: 100, atk_power: 60)

jin_playable = Playable.new(unit: jin)
ishikawa_playable = Playable.new(unit: ishikawa)

villains = [archer, spear, sword]
vg = VillainGroup.new(name: "Mongols", units: villains)

jin_members = [jin_playable, yuna, ishikawa_playable]
jin_party = PlayableGroup.new(name: "Jin Sakai party", units: jin_members)

game = Game.new(team1: jin_party, team2: vg)

game.simulate