require 'mysql2'

# def create_db_client
#     client = Mysql2::Client.new(
#                 :host => ENV["APP_HOST"],
#                 :username => ENV["DB_USER"],
#                 :password => ENV["DB_PASSWORD"],
#                 :database => ENV["DB_NAME"]
#     )
#     client
# end

class MySQLDB
    @@client = nil
    def self.get_client
        if !@@client
            @@client = Mysql2::Client.new(
                :host => ENV["APP_HOST"],
                :username => ENV["DB_USER"],
                :password => ENV["DB_PASSWORD"],
                :database => ENV["DB_NAME"]
            )
        end
        @@client
    end

    def self.transaction
        get_client
        raise false unless block_given?
        begin
            @@client.query("START TRANSACTION;")
            yield
            # @@client.query("COMMIT;")
            @@client.query("COMMIT;")
            return true
        rescue => ex
            @@client.query("ROLLBACK;")
            # raise ex
            return false
        end
    end

    def self.commit
        get_client
        @@client.query("START TRANSACTION;")
        @@client.query(
            "select sleep(2)"
        )
        sleep(3)
        @@client.query("COMMIT;")
    end
end