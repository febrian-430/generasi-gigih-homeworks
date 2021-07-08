
require_relative "group"

class VillainGroup < Group
    def update_state()
        if !self.is_dead?
            @units.delete_if { |unit| unit.is_dead? || unit.has_fled? }
        end
    end
end