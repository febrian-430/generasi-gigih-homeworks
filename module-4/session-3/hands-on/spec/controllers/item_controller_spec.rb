require 'rspec'
require './models/item'
require './controllers/item_controller'
require './db/mysql_connector'

describe ItemController do
    let(:client) { MySQLDB.get_client }
    describe '#create_form' do
        it 'renders create item form' do
            categories = Category.all
            renderer = ERB.new(File.read("./views/item/create.erb"))
            expect(ItemController.create_form).to eq(renderer.result(binding))
        end
    end

    describe '#update' do
        let(:item_in_db) { Item.new(1, "dummy", 1)}

        before(:each) do 
            client.query("DELETE FROM items")
            client.query("INSERT INTO items(name, price) VALUES ('#{item_in_db.name}', '#{item_in_db.price}')")
        end
        
        context 'given an invalid item id' do
            it 'should return false' do
                params = {
                    "id" => 999,
                    "name" => "boom",
                    "price" => 123
                }
                expect(ItemController.update(params)).to eq(false)
            end
        end

        context 'given a valid id with empty name and price' do
            it 'should return false' do
                params = {
                    "id" => 99,
                    "name" => "",
                    "price" => nil
                }
                expect(ItemController.update(params)).to eq(false)
            end
        end

        # context 'given a valid id with valid name and price with no categories' do
        #     it 'should return true and updates the data' do
        #         params = {
        #             "id" => 1,
        #             "name" => "updated",
        #             "price" => 999
        #         }
        #         expect(ItemController.update(params)).to eq(false)
        #     end
        # end
    end
end