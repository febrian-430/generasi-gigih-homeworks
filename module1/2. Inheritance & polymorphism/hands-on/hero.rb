require_relative "player"

class Hero < Player

    def initialize(name:, hp:, atk_power:, deflect_chance:)
        super(name: name, hp: hp, atk_power: atk_power)
        @deflect_chance = deflect_chance
    end

    def deflect?
        return rand(1..100) <= @deflect_chance ? true : false
    end

    def receive_hit(hit_power:)
        if self.deflect?
            puts "#@name deflected the attack"
        else
            super
        end
    end
end