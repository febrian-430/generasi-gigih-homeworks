require_relative "player"

class Hero < Player
    attr_writer :group
    def initialize(name:, hp:, atk_power:, deflect_chance:)
        super(name: name, hp: hp, atk_power: atk_power)
        @deflect_chance = deflect_chance
        @group = nil
    end

    def deflect?
        return rand(1..100) <= @deflect_chance ? true : false
    end
    

    #TODO: abstract so not all hero can heal
    def heal(target:)
        heal_amount = 20
        target.receive_heal(heal_amount: heal_amount)
        puts "#@name healed #{target.name} for #{heal_amount}"
    end

    def receive_hit(hit_power:)
        if self.is_dead?
            return
        end
        if self.deflect?
            puts "#@name deflected the attack"
        else
            super
        end
    end
end