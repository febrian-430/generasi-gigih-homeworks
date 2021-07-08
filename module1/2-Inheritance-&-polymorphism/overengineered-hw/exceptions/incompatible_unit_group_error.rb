class IncompatibleUnitGroupError < StandardError
    def initialize(msg="The given unit type for the group type is incompatible")
        super
    end
end