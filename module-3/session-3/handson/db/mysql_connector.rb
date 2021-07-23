require 'mysql2'

def create_db_client
    client = Mysql2::Client.new(
        :host => ENV["APP_HOST"],
        :username => ENV["DB_USER"],
        :password => ENV["DB_PASSWORD"],
        :database => ENV["DB_NAME"]
    )
end