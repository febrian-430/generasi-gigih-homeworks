class Item
    attr_reader :name
    attr_accessor :id

    def initialize(name)
        @id = -1
        @name = name
    end
end