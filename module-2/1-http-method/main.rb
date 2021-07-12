require 'sinatra'
require 'sinatra/reloader'
require_relative "storage"
require_relative "item"


storage = Storage.new

get '/' do
    [201, nil, '<h1 style="color:blue">hello world</h1>']
end


get "/login" do
    erb :login
end

post '/login' do
    if params["username"] == 'admin' && params["password"] == "admin"
        return "Logged In"
    else 
        redirect "/login"
    end
end



get "/items" do
    erb :items, locals: {
        items: storage.to_a
    }
end

get "/items/create" do
    erb :new_item
end

post "/items" do
    name = params["name"]

    if name == ""
        redirect "/items/create"
    else
        storage.store(Item.new(name))
        redirect "/items"
    end
end

get "/:id" do
    id = params["id"]
    color = params["color"] ? params["color"] : "Green"
    erb :message, locals: {
        id: id,
        color: color
    }
end