require 'sinatra'
require './models/item.rb'
require './models/category.rb'

class ItemController

    def self.create_form
        categories = Category.all
        ERB.new(File.read("./views/create.erb")).result(binding)
    end

    def self.create_item(params)
        item = Item.new(nil,
            params["name"],
            params["price"]
        )
        item.categories = params["categories"].map{ |category_id| Category.new(category_id, nil)} if params["categories"]

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

    def self.update(params)
        id = params["id"].to_i
        item = Item.get_item_by_id(id)
        if !item 
            return false
        else
            item.name = params["name"]
            item.price = params["price"].to_i
            
            item.categories = params["categories"] ? 
                params["categories"].map{|category| Category.new(category.to_i, nil) } 
                :
                []
            
            item.update
        end
    end
end