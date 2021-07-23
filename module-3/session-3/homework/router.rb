require 'sinatra'
require 'sinatra/reloader'
require './models/item.rb'
require './models/category.rb'
require './controllers/item_controller.rb'
require './controllers/category_controller.rb'
require './db/mysql_connector'
require 'dotenv'

Dotenv.load

get '/' do
    items = Item.get_all_items
    erb :index, locals: {
        items: items
    }
end

get '/items' do
    ItemController.items(params)
end

get "/items/new" do
    erb :create
end

post '/items' do
    return redirect('/') if ItemController.create_item(params)
end


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

get '/categories' do
    CategoryController.all_categories
end

post '/categories' do
    redirect('/categories') if CategoryController.create_category(params)
end

get '/categories/create' do
    CategoryController.category_form
end



not_found do
    erb :not_found
end