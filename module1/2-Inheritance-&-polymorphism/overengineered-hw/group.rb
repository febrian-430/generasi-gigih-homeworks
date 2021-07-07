
#abstraction
class Fightable
    def targeted_action(target:)
    end

    def is_dead?
    end
end

class Group < Fightable
    attr_reader :name
    def initialize(name:, units: )
        @units = units
        @name = name

        @units.map do |unit|
            if unit.instance_of? Hero 
                unit.group = self
            end
        end
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
            return @units[rand_num]
        else
            return nil
        end
    end

    def is_dead?
        return @units.length == 0
    end

    def targeted_action(target:)
        self.update_state
        if target.kind_of? Player
            @units.each do |unit|
                unit.targeted_action(target: target)
            end
        else
            @units.each do |unit|
                enemy_unit = target.get_random_targeted_member
                unit.targeted_action(target: enemy_unit)
            end
        end
    end

    def update_state()
        if !self.is_dead?
            @units.delete_if { |unit| unit.is_dead? }
        end
    end
end

class VillainGroup < Group
    def update_state()
        if !self.is_dead?
            @units.delete_if { |unit| unit.is_dead? || unit.has_fled? }
        end
    end
end