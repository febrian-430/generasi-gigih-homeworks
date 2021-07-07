require_relative "villain"

class Swordsman < Villain
    def initialize(hp:, atk_power:)
        super(name: "Mongol Swordsman", hp: hp, atk_power: atk_power)
    end

    def hit(target:)
        puts "#{@name} slashes #{target.name} dealing #{@atk_power.to_s} dmg"
        target.receive_hit(hit_power: @atk_power)
    end
end