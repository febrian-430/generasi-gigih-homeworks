require "mysql2"

client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "123qweasd", :database => "test")


results = client.query("SELECT * FROM users")

results.each do |row|
    puts "#{row["ID"]} : #{row["name"]}"
end
