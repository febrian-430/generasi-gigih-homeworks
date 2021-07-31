require './db/mysql_connector.rb'


class Category
    attr_accessor :name, :id

    def initialize(id, name)
        @id = id
        @name = name
        @items = []
    end

    def self.bind_to_categories(raw)
        categories = []
        raw.each do | data |
            categories << Category.new(data["id"], data["name"])
        end
        categories
    end

    def self.all
        client = MySQLDB.get_client
        raw = client.query("select * from categories ORDER BY ID ASC")
        return bind_to_categories(raw)
    end

    def self.by_id(id)
        client = MySQLDB.get_client
        raw = client.query("select * from categories where id = #{id}")
        return bind_to_categories(raw)[0]
    end

    def self.of_item(item_id)
        client = MySQLDB.get_client
        raw = client.query("
            select c.id, c.name 
            from categories c
            join item_categories ic on ic.category_id = c.id
            where ic.item_id = #{item_id} 
        ")
        return bind_to_categories(raw)
    end

    def save?
        return false if @name.nil? || @name.empty?
        true
    end

    def save
        return false if !self.save?
        client = MySQLDB.get_client
        client.query("insert into categories(name) values ('#{@name}')")
        true
    end

    def update?
        return false if @id.nil?
        return false if @name.nil? || @name.empty?
        true
    end

    def update
        return false if !self.update?
        client = MySQLDB.get_client
        client.query("update categories set name = '#{@name}' where id = #{@id}")
        true
    end

    def delete?
        return false if @id.nil?
        true
    end

    def delete
        return false if !self.delete?
        client = MySQLDB.get_client
        client.query("delete from categories where id = #{@id}")
        true
    end
end