class Storage
    def initialize()
        @items = []
        @nextId = 1
    end

    def store(item)
        item.id = @nextId
        @items.append(item)
        @nextId+=1
    end

    def to_a
        return @items
    end
end