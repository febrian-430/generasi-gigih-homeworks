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


    def self.items(params)
        if params["category"]
            items = Item.filter_by_category(params["category"])
        else
            items = Item.get_all_items()
        end
        renderer = ERB.new(File.read('./views/index.erb'))
        renderer.result(binding)
    end

end