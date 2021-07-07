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

class Archer < Villain
    def initialize(hp:, atk_power:)
        super(name: "Mongol Archer", hp: hp, atk_power: atk_power)
    end

    def hit(target:)
        puts "#{@name} shoots an arrow at #{target.name} dealing #{@atk_power.to_s} dmg"
        target.receive_hit(hit_power: @atk_power)
    end
end

class Swordsman < Villain
    def initialize(hp:, atk_power:)
        super(name: "Mongol Swordsman", hp: hp, atk_power: atk_power)
    end

    def hit(target:)
        puts "#{@name} slashes #{target.name} dealing #{@atk_power.to_s} dmg"
        target.receive_hit(hit_power: @atk_power)
    end
end

class Spearman < Villain
    def initialize(hp:, atk_power:)
        super(name: "Mongol Spearman", hp: hp, atk_power: atk_power)
    end

    def hit(target:)
        puts "#{@name} stabs #{target.name} dealing #{@atk_power.to_s} dmg"
        target.receive_hit(hit_power: @atk_power)
    end
end