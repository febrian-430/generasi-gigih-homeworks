require 'rspec'
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
        context 'given a valid Item instance' do
            it 'should return true and the data is inserted' do
                item = Item.new(nil, "item 1", 123)
                
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