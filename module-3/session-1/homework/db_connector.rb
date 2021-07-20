require 'mysql2'
require_relative "category"
require_relative "item"

def create_db_client
    client = Mysql2::Client.new(
        :host => "localhost",
        :username => "root",
        :password => "123qweasd",
        :database => "food_oms"
    )
end

def bind_to_items(raw)
    items = []
    raw.each do | data |
        category = nil
        if data["category_name"]
            category = Category.new(data["category_id"], data["category_name"])
        end
        item = Item.new(data["id"], data["name"], data["price"],  category)
        items.push(item)
    end
    return items
end

def bind_to_categories(raw)
    categories = []
    raw.each do | data |
        categories << Category.new(data["id"], data["name"])
    end
    return categories
end

def get_all_items
    client = create_db_client
    raw = client.query("select * from items")
    items = bind_to_items(raw)
    return items
end

def get_all_categories
    client = create_db_client
    categories = client.query("select * from categories")
    return bind_to_categories(categories)
end

def get_all_items_with_categories
    client = create_db_client
    raw = client.query(
        "select i.*, c.id as category_id, c.name as category_name
         from items i 
         join item_categories ic on i.id = ic.item_id
         join categories c on c.id = ic.category_id"
    )
    
    items = bind_to_items(raw)
    return items
end

def get_items_with_price_below(price)
    client = create_db_client
    raw = client.query(
        "select * from items
        where price < #{price}"
    )
    items = bind_to_items(raw)
end

def get_item_by_id(id)
    client = create_db_client
    raw = client.query("
        select i.id, i.name, i.price, c.id as category_id, c.name as 'category_name'
        from items i
        left join item_categories ic on ic.item_id = i.id
        left join categories c on ic.category_id = c.id
        where i.id = #{id}
    ")
    items = bind_to_items(raw)
    return items[0]
end

def create_new_item(name, price)
    client = create_db_client
    client.query("INSERT INTO items(name, price) VALUES('#{name}', #{price})")
end

def update_item(item)
    client = create_db_client
    result = client.query("
        SELECT 1 FROM item_categories
        WHERE item_id = #{item.id}
    ")

    categoryStatement = "INSERT INTO item_categories(item_id, category_id) VALUES (#{item.id}, #{item.category.id});"
    
    #if item already has a category
    if result.each.length > 0
        categoryStatement = "UPDATE item_categories SET category_id = #{item.category.id} WHERE item_id = #{item.id};"
    end
    
        client.query("START TRANSACTION;")
        client.query("
            UPDATE items 
            SET name = '#{item.name}', 
                price = #{item.price}
            WHERE id = #{item.id};
        ")
        client.query(categoryStatement)
        client.query("COMMIT;")
        return true
    
end

def delete_item_by_id(id)
    client = create_db_client
    client.query("DELETE FROM items WHERE id = #{id}")
end