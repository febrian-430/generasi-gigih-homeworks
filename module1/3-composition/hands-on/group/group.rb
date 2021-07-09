require_relative "../fightable"
require "./exceptions/incompatible_unit_group_error.rb"


class Group
    attr_reader :name
    def initialize(name:, units: )
        @units = []
        @name = name

        units.each do |unit|
            if unit.kind_of?(Fightable)
                @units.append(unit)
            else
                raise IncompatibleUnitGroupError, "Group must contain only Player class or Playable class and its derivatives"
            end
        end
    end

    def get_random_targeted_member
        return @units.sample
    end

    def is_dead?
        return @units.length == 0
    end

    def targeted_action(target:)
        if !self.is_dead?
            @units.each do |unit|
                if !unit.is_dead?
                    unit.targeted_action(target: target)
                end
            end
        end 
    end

    def update_state
        @units.delete_if { |unit| unit.is_dead? }
    end

    def to_a()
        return @units
    end

    def to_s
        out = "#@name Party\n"
        @units.each {
            |unit|
            out += "\t #{unit.to_s}\n"
        }
        return out
    end
end

