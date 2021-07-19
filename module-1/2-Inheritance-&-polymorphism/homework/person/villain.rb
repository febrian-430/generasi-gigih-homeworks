require_relative "player"

class Villain < Player
    def initialize(name:, hp:, atk_power:)
        super
        @has_fled = false
    end

    def flee?
        if @hp <= 50 && rand(1..2) == 1
            @has_fled = true
        end
        return @has_fled 
    end

    def has_fled?
        return @has_fled
    end

    def is_dead? 
        return @has_fled || @hp == 0
    end

    def receive_hit(hit_power:)
        if self.flee?
            puts "#@name has fled the battle"
        else
            super
        end
    end
end