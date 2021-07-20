require 'sinatra'
# require 'sinatra/reloader'

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

    create_new_item(name, price)

    redirect('/')
end

#TODO
#SHOW WITH CATEGORY
get '/items/:id' do
    id = params["id"].to_i
    item = get_item_by_id(id)
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
    item = get_item_by_id(id)
    if !item 
        return status 404
    else
        categories = get_all_categories
        erb :edit, locals: {
            item: item,
            categories: categories
        }
    end
end

post '/items/:id/update' do
    id = params["id"].to_i
    item = get_item_by_id(id)
    if !item 
        return status 404
    else
        item.name = params["name"]
        item.price = params["price"].to_i
        item.category = Category.new(params["category"], nil)
        success = update_item(item)
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
    delete_item_by_id(id)
    redirect('/')
end 

not_found do
    erb :not_found
end