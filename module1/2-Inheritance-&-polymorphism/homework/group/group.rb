require_relative "../fightable"
require "./exceptions/incompatible_unit_group_error.rb"


class Group < Fightable
    attr_reader :name
    def initialize(name:, units: )
        @units = []
        @name = name

        units.each do |unit|
            if unit.kind_of?(Player) || unit.kind_of?(Playable)
                @units.append(unit)
            else
                raise IncompatibleUnitGroupError, "Group must contain only Player class or Playable class and its derivatives"
            end
        end
    end

    def to_a()
        return @units
    end

    def get_random_targeted_member
        return @units.sample
    end

    def is_dead?
        return @units.length == 0
    end

    def targeted_action(target:)
        self.update_state
        @units.each do |unit|
            if !unit.is_dead?
                unit.targeted_action(target: target)
            end
        end
    end

    def update_state
        if !self.is_dead?
            @units.delete_if { |unit| unit.is_dead? }
        end
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

