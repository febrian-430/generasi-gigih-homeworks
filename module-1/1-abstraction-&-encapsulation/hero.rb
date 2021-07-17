require_relative "player"

class Hero < Player

    def deflect?
        return rand(1..100) <= 80 ? true : false
    end

    def receive_hit(hit_power:)
        if self.deflect?
            puts "Attack deflected"
        else
            super
        end
    end
end