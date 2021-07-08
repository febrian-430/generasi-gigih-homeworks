require_relative "group"
require "./exceptions/incompatible_unit_group_error.rb"

#group that has at least one playable object in its units and
#current implementation: the group loses when a playable unit dies
class PlayableGroup < Group

    def initialize(name:, units:)
        super
        @units = []
        playable_unit = nil
        units.each do |unit|
            if unit.kind_of?(Player) || unit.kind_of?(Playable)
                if unit.kind_of?(Playable)
                    playable_unit = unit
                end
                @units.append(unit)
            else
                raise IncompatibleUnitGroupError
            end  
        end

        if !playable_unit
            raise IncompatibleUnitGroupError, "Playable group must contain at least one playable unit"
        end
        playable_unit.group = self
        @is_playable_dead = false
    end

    def is_dead?
        return super || @is_playable_dead
    end

    def update_state
        @units.each {
            |member|
            if member.instance_of?(Playable) && member.is_dead?
                @is_playable_dead = true
            end
        }
        super
    end
end