require_relative "group"

#group that has at least one playable object in its units and
#current implementation: the group loses when a playable unit dies
class PlayableGroup < Group

    def initialize(name:, units:)
        super
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