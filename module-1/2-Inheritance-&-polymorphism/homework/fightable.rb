#abstraction
class Fightable
    def targeted_action(target:)
        raise NotImplementedError
    end

    def is_dead?
        raise NotImplementedError
    end

    def receive_hit(hit_power: )
        raise NotImplementedError
    end

    def receive_heal(heal_amount:)
        raise NotImplementedError
    end
end