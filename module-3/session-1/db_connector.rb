require 'mysql2'
require_relative "category"
require_relative "item"

def create_db_client
    client = Mysql2::Client.new(
        :host => "localhost",
        :username => "root",
        :password => "123qweasd",
        :database => "generasi_gigih"
    )
end

def get_all_items
    client = create_db_client
    raw = client.query("select * from items")

    items = []

    raw.each do | data |
        item = Item.new(data["id"], data["name"], data["price"])
        items.push(item)
    end
    return items
end

def get_all_categories
    client = create_db_client
    categories = client.query("select * from categories")
end

def get_all_items_with_categories
    client = create_db_client
    raw = client.query(
        "select i.*, c.name as category
         from items i 
         join item_categories ic on i.id = ic.item_id
         join categories c on c.id = ic.category_id"
    )
    
    items = []

    raw.each do | data |
        category = Category.new(data["id"], data["category"])
        item = Item.new(data["id"], data["name"], data["price"],  category)
        items.push(item)
    end
    return items
end

def get_items_with_price_below(price)
    client = create_db_client
    items = client.query(
        "select * from items
        where price < #{price}"
    )
end

def create_new_item(name, price)
    client = create_db_client
    client.query("INSERT INTO items(name, price) VALUES('#{name}', #{price})")
end