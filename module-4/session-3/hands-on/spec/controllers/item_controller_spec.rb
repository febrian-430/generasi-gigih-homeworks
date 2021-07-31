require 'rspec'
require './models/item'
require './controllers/item_controller'
require './db/mysql_connector'

describe ItemController do
    let(:client) { MySQLDB.get_client }
 
    before(:each) do
        @items = [Item.new(1, "123", 456), Item.new(2, "def", 12312)]
        @categories = [Category.new(1, "fake"), Category.new(2, "fakee"), Category.new(3, "boom")]
        @items[0].categories = [@categories[0], @categories[1]]
    end

    describe '#create_form' do
        it 'renders create item form' do
            categories = [Category.new(1, "123")]
            renderer = ERB.new(File.read("./views/item/create.erb"))
            allow(Category).to receive(:all).and_return(categories)
            expect(ItemController.create_form).to eq(renderer.result(binding))
        end
    end

    describe '#index' do
        it 'renders index form' do
            items = [Item.new(1, 'a', 123), Item.new(2, 'dada', 421)]
            allow(Item).to receive(:get_all_items).and_return(items)
            renderer = ERB.new(File.read("./views/item/index.erb"))
            expect(ItemController.index).to eq(renderer.result(binding))
        end

        it 'displays empty list' do
            items = []
            allow(Item).to receive(:get_all_items).and_return(items)
            renderer = ERB.new(File.read("./views/item/index.erb"))
            expect(ItemController.index).to eq(renderer.result(binding))
        end
    end

    describe '#items' do
        
        it 'renders all items form' do
            allow(Item).to receive(:get_all_items).and_return(@items)
            expect(Item).not_to receive(:filter_by_category)
            expect(Item).to receive(:get_all_items)
            items = @items
            renderer = ERB.new(File.read("./views/item/index.erb"))
            expect(ItemController.items({})).to eq(renderer.result(binding))
        end

        it 'renders items with specified category' do
            params = {"category" => "fake"}
            allow(Item).to receive(:filter_by_category).and_return([@items[0]])
            expect(Item).to receive(:filter_by_category).with(params["category"])
            expect(Item).not_to receive(:get_all_items)
            items = [@items[0]]
            renderer = ERB.new(File.read("./views/item/index.erb"))
            expect(ItemController.items(params)).to eq(renderer.result(binding))
        end
    end

    describe '#edit_form' do
        context 'given valid id' do
            it 'should give the edit form for the item' do
                params = {
                    "id" => 1
                }
                items = @items.select {
                    |item|
                    item.id == params["id"]
                }
                item = items[0]

                categories = @categories

                allow(Item).to receive(:get_item_by_id).and_return(item)
                allow(Category).to receive(:all).and_return(categories)

                renderer = ERB.new(File.read("./views/item/edit.erb"))
                expect(ItemController.edit_form(params)).to eq(renderer.result(binding))
            end
        end

        context 'given invalid id' do
            it 'should give error_not_found view' do
                params = {
                    "id" => 123
                }
                item = nil
                categories = @categories

                allow(Item).to receive(:get_item_by_id).and_return(nil)
                allow(Category).to receive(:all).and_return(categories)

                renderer = ERB.new(File.read("./views/not_found.erb"))
                expect(ItemController.edit_form(params)).to eq(renderer.result(binding))
            end
        end
    end

    describe '#show' do
        
        context 'given valid id' do
            it 'should give the edit form for the item' do
                params = {
                    "id" => 1
                }
                items = @items.select {
                    |item|
                    item.id == params["id"]
                }
                item = items[0]

                allow(Item).to receive(:get_item_by_id).and_return(item)

                renderer = ERB.new(File.read("./views/item/show.erb"))
                expect(ItemController.show(params)).to eq(renderer.result(binding))
            end
        end

        context 'given invalid id' do
            it 'should give error_not_found view' do
                params = {
                    "id" => 123
                }
                item = nil
                categories = @categories

                allow(Item).to receive(:get_item_by_id).and_return(nil)
                allow(Category).to receive(:all).and_return(categories)

                renderer = ERB.new(File.read("./views/not_found.erb"))
                expect(ItemController.edit_form(params)).to eq(renderer.result(binding))
            end
        end
    end

    describe '#update' do
        before(:each) do 
            # client.query("DELETE FROM items")
            # client.query("INSERT INTO items(name, price) VALUES ('#{item_in_db.name}', '#{item_in_db.price}')")
            @item = Item.new(1, "dummy", 1)
        end
        
        context 'given an invalid item id' do
            it 'should return false' do
                params = {
                    "id" => 999,
                    "name" => "boom",
                    "price" => 123
                }

                allow(Item).to receive(:get_item_by_id).and_return(nil)

                expect(ItemController.update(params)).to eq(false)
            end
        end

        context 'given a valid id with empty name and price' do
            it 'should return false' do
                params = {
                    "id" => 1,
                    "name" => "",
                    "price" => nil
                }

                fake_item = double
                allow(Item).to receive(:get_item_by_id).and_return(fake_item)
                
                expect(fake_item).not_to receive(:update)
                expect(fake_item.update).to eq(true)

                expect(ItemController.update(params)).to eq(false)
            end
        end

        context 'given a valid id with valid name and price with no categories' do
            it 'should return true and updates the data' do
                params = {
                    "id" => 1,
                    "name" => "updated",
                    "price" => 999,
                    "categories" => [1,2,3]
                }

                expect(ItemController.update(params)).to eq(false)
            end
        end
    end
end