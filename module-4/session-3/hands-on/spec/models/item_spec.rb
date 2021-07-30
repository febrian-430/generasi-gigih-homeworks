require 'rspec'
require 'mysql2'
require './models/item'
require './db/mysql_connector'

describe Item do
    describe '#save?' do
        context 'given valid Item instance with no categories' do
            it 'should return true' do
                item = Item.new(nil, "item name", 123)
                expected = true
                expect(item.save?).to eq(expected)
            end
        end

        context 'given an item with no name' do
            it 'should return false' do
                item = Item.new(nil, "", 123)
                expected = false
                expect(item.save?).to eq(expected)
            end
        end
    end

    describe '#save' do
        let(:client){ MySQLDB.get_client }
        before(:each) do
            client.query("DELETE FROM items")
        end
        context 'given an item instance with saveable attribute values' do
            it 'should return true and the data is inserted' do
                item = Item.new(nil, "item 1", 123)

                dummy_client = double
                allow(MySQLDB).to receive(:get_client).and_return(dummy_client)
                expect(dummy_client).to receive(:query).with("INSERT INTO items(name, price) VALUES ('#{item.name}', #{item.price});")
                successful = item.save
                
                result = client.query("SELECT * FROM items LIMIT 1")
                fetched_item = Item.new(nil, nil, nil)

                result.each do |row|
                    puts row.inspect
                    fetched_item.id = row["id"].to_i
                    fetched_item.name = row["name"]
                    fetched_item.price = row["price"].to_i
                end
                expect(successful).to eq(true)
                expect(fetched_item.name).to eq(item.name)
                expect(fetched_item.price).to eq(item.price)
            end
        end
    end
end