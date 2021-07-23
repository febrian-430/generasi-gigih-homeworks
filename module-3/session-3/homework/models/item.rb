require './db/mysql_connector.rb'


class Item
    attr_accessor :name, :price, :id, :category

    def initialize(id, name, price)
        @id = id
        @name = name
        @price = price
        @categories = categories
    end

    def self.bind_to_items(raw)
        items = []
        raw.each do | data |
            item = Item.new(data["id"], data["name"], data["price"])
            items.push(item)
        end
        return items
    end
    
    
    def self.get_all_items
        client = create_db_client
        raw = client.query("select * from items")
        items = bind_to_items(raw)
        return items
    end
    
    def self.get_all_items_with_categories
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
    
    def self.get_items_with_price_below(price)
        client = create_db_client
        raw = client.query(
            "select * from items
            where price < #{price}"
        )
        items = bind_to_items(raw)
        return items
    end
    
    def self.get_item_by_id(id)
        client = create_db_client
        raw = client.query("
            select i.id, i.name, i.price, c.id as category_id, c.name as 'category_name'
            from items i
            left join item_categories ic on ic.item_id = i.id
            left join categories c on ic.category_id = c.id
            where i.id = #{id}
        ")
        items = bind_to_items(raw)
        if items.length > 0
            item = items[0] 
            raw = client.query("
                    select * from categories c join item_categories ic on ic.category_id = c.id where ic.item_id = #{item.id}
                ")
            raw.each do |row|
                item.categories << Category.new(row["id"], row["name"])
            end
            return item
        else
            return nil
        end
    end
    
    def save?
        return false if @name.nil?
        return false if @price.nil?
        true
    end

    def save
        return false unless save?
        client = create_db_client
        client.query("INSERT INTO items(name, price) VALUES('#{@name}', #{@price})")
        true
    end
    
    def update?
        return false if @id.nil?
        return false if @name.nil?
        return false if @price.nil?
        return false if @category.nil?
        true
    end

    def update
        return false unless update?
        client = create_db_client
        result = client.query("
            SELECT 1 FROM item_categories
            WHERE item_id = #{@id}
        ")
    
        categoryStatement = "INSERT INTO item_categories(item_id, category_id) VALUES (#{@id}, #{@category.id});"
        
        #if item already has a category
        if result.each.length > 0
            categoryStatement = "UPDATE item_categories SET category_id = #{@category.id} WHERE item_id = #{@id};"
        end
        
        begin
            client.query("START TRANSACTION;")
            client.query("
                UPDATE items 
                SET name = '#{@name}', 
                    price = #{@price}
                WHERE id = #{@id};
            ")
            client.query(categoryStatement)
            client.query("COMMIT;")
            return true
        rescue
            client.query("ROLLBACK;")
            return false
        end
    end
    
    def delete?
        return false if @id.nil?
        true
    end

    def delete
        return false unless delete?
        client = create_db_client
        client.query("DELETE FROM items WHERE id = #{@id}")
    end
end