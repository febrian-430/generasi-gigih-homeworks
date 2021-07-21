require './db/mysql_connecetor.rb'


class Category
    attr_accessor :name, :id

    def initialize(id, name)
        @id = id
        @name = name
    end

    def self.bind_to_categories(raw)
        categories = []
        raw.each do | data |
            categories << Category.new(data["id"], data["name"])
        end
        return categories
    end

    def self.all
        client = create_db_client
        categories = client.query("select * from categories")
        return bind_to_categories(categories)
    end
end