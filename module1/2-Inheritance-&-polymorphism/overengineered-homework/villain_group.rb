
require_relative "group"
require "./exceptions/incompatible_unit_group_error.rb"

class VillainGroup < Group
    def initialize(name:, units:)
        @units = []
        units.each do |unit|
            if unit.kind_of?(Villain)
                @units.append(unit)
            else
                raise IncompatibleUnitGroupError
            end
        end
    end

    def update_state()
        if !self.is_dead?
            @units.delete_if { |unit| unit.is_dead? || unit.has_fled? }
        end
    end
end