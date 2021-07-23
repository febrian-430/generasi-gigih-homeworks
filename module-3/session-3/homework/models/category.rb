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
        client = create_db_client
        categories = client.query("select * from categories")
        return bind_to_categories(categories)
    end

    def save?
        false if @name.nil?
        true
    end

    def save
        false if self.save?
        client = create_db_client
        client.query("insert into categories(name) values ('#{@name}')")
        true
    end
end