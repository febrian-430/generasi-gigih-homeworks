require 'sinatra'
require 'sinatra/reloader'
require './models/item.rb'
require './models/category.rb'


require './db_connector'

get '/' do
    items = get_all_items
    erb :index, locals: {
        items: items
    }
end

get "/items/new" do
    erb :create
end

post '/items' do
    name = params["name"]
    price = params["price"]

    Item.new(nil, name, price).save

    redirect('/')
end

#TODO
#SHOW WITH CATEGORY
get '/items/:id' do
    id = params["id"].to_i
    item = Item.get_item_by_id(id)
    if !item 
        return status 404
    else
        erb :show, locals: {
            item: item
        }
    end
end


get '/items/:id/edit' do
    id = params["id"].to_i
    item = Item.get_item_by_id(id)
    if !item 
        return status 404
    else
        categories = Category.all
        erb :edit, locals: {
            item: item,
            categories: categories
        }
    end
end

post '/items/:id/update' do
    id = params["id"].to_i
    item = Item.get_item_by_id(id)
    if !item 
        return status 404
    else
        item.name = params["name"]
        item.price = params["price"].to_i
        item.category = Category.new(params["category"], nil)
        success = item.update
        if success 
            puts "update success"
        else
            puts "update failed"
        end
        redirect("/items/#{item.id}")
    end
end

#DELETE DAN SHOW

post '/items/:id/delete' do
    id = params["id"].to_i
    Item.new(id, "", "").delete
    redirect('/')
end 

not_found do
    erb :not_found
end