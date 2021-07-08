require_relative "villain"

class Archer < Villain
    def initialize(hp:, atk_power:)
        super(name: "Mongol Archer", hp: hp, atk_power: atk_power)
    end

    def hit(target:)
        puts "#{@name} shoots an arrow at #{target.name} dealing #{@atk_power.to_s} dmg"
        target.receive_hit(hit_power: @atk_power)
    end
end