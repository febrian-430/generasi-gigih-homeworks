require 'sinatra'
require './models/item.rb'
require './models/category.rb'

class ItemController

    def self.create_item(param)
        item = Item.new(nil,
            param["name"],
            param["price"]
        )
        return item.save
    end

end