require_relative "player"


#abstraction
class Fightable
    def targeted_action(target:)
    end
end

class Group < Fightable
    attr_reader :name
    def initialize(name:, units: )
        @units = units
        @name = name
    end

    def no_units_left?
        return @units.length == 0
    end

    def get_members()
        return @units
    end

    def get_random_targeted_member
        if !self.no_units_left?
            rand_num = rand(0..@units.length)
            return self.get_member(index: rand_num)
        else
            return nil
        end
    end

    def targeted_action(target:)
        if target.kind_of? Player
            @units.each do |unit|
                unit.targeted_action(target)
            end
        else
            @units.each do |unit|
                enemy_unit = target.get_random_targeted_member
                unit.targeted_action(enemy_unit)
            end
        end
    end
end