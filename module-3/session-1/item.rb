class Item
    attr_accessor :name, :price, :id, :category

    def initialize(id, name, price, category = nil)
        @id = id

        @name = name
        @price = price
        @category = category
    end
end