#abstraction
class Fightable
    def targeted_action(target:)
        raise NotImplementedError
    end

    def is_dead?
        raise NotImplementedError
    end
end