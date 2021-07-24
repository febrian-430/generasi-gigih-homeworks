require './db/mysql_connector.rb'


class Item
    attr_accessor :name, :price, :id, :categories

    def initialize(id, name, price)
        @id = id
        @name = name
        @price = price
        @categories = []
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
        client = MySQLDB.get_client
        raw = client.query("select * from items")
        items = bind_to_items(raw)
        return items
    end
    
    def self.get_all_items_with_categories
        client = MySQLDB.get_client
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
        client = MySQLDB.get_client
        raw = client.query(
            "select * from items
            where price < #{price}"
        )
        items = bind_to_items(raw)
        return items
    end
    
    def self.get_item_by_id(id)
        client = MySQLDB.get_client
        raw = client.query("
            select id, name, price
            from items
            where id = #{id}
        ")
        items = bind_to_items(raw)
        
        if items.length > 0
            item = items[0] 
            raw = client.query("
                    select c.id, c.name from categories c 
                    join item_categories ic on ic.category_id = c.id 
                    where ic.item_id = #{item.id}
                ")
            

            item.categories = Category.bind_to_categories(raw)
            return item
        else
            return nil
        end
    end

    def self.filter_by_category(category_name)
        client = MySQLDB.get_client
        raw = client.query("
            select i.* from items i
            join item_categories ic on ic.item_id = i.id 
            join categories c on c.id = ic.category_id
            where c.name = '#{category_name}'
        ")  
        items = bind_to_items(raw)
        return items
    end

    def self.last
        client = MySQLDB.get_client
        raw = client.query("
            select * from items order by id desc limit 1
        ")
        return bind_to_items(raw)[0]
    end
    
    def save?
        return false if @name.nil?
        return false if @price.nil?
        true
    end

    def save
        return false unless save?
        client = MySQLDB.get_client
        success = MySQLDB.transaction {
            result = client.query("INSERT INTO items(name, price) VALUES('#{@name}', #{@price});")
            @id = client.last_id
            insert_category_statement = nil
            if !@categories.empty?
                bulk = []
                @categories.each do |category|
                    bulk << "(%s, %d)" % [@id, category.id]
                end
                insert_category_statement = "INSERT INTO item_categories(item_id, category_id) VALUES %s;" % bulk.join(",")
            end
            puts insert_category_statement.inspect
            client.query(insert_category_statement)
        }
        success
    end

    def unlink_category
    end
    
    def update?
        return false if @id.nil?
        return false if @name.nil?
        return false if @price.nil?
        true
    end

    def update
        return false unless update?
        client = MySQLDB.get_client
        
        current_category_ids = Category.of_item(self.id).map{ |category| category.id }
        updated_categories = self.categories&.map{ |category| category.id }

        new_categories = []
        deleted_categories = []
        if updated_categories
            #get new categories id that is not in current category
            new_categories = updated_categories - current_category_ids

            #get the category id to delete from current category
            deleted_categories = current_category_ids - current_category_ids.intersection(updated_categories)
        end

        puts "new: #{new_categories.inspect}"
        puts "deleted: #{deleted_categories.inspect}"
        create_statement = nil
        if new_categories&.length > 0
            bulk_insert = []
            new_categories.each do |category_id|
                bulk_insert << "(#{self.id}, #{category_id})"
            end
            #delete the last comma and change it into semicolon
            create_statement = "INSERT INTO item_categories(item_id, category_id) VALUES %s;" % bulk_insert.join(",")
            puts create_statement.inspect
        end

        delete_statement = nil
        if deleted_categories&.length > 0
            delete_statement = "DELETE FROM item_categories WHERE item_id = #{self.id} AND category_id IN(%s);" % deleted_categories.join(",")
            puts delete_statement.inspect
        end
        begin
            client.query("START TRANSACTION;")
            client.query("
                UPDATE items 
                SET name = '#{@name}', 
                    price = #{@price}
                WHERE id = #{@id};
            ")
            client.query(create_statement) if !create_statement.nil?
            client.query(delete_statement) if !delete_statement.nil?
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
        client = MySQLDB.get_client
        client.query("DELETE FROM items WHERE id = #{@id}")
    end
end