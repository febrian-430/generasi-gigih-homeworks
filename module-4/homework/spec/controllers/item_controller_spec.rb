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

    describe '#create_item' do
        context 'given parameter with empty name' do
            it 'should return false and not save the data' do
                params = {
                    "name" => nil,
                    "price" => 123
                    # "categories" => [1,2]
                }

                fake_item = double
                allow(Item).to receive(:new).and_return(fake_item)
                # allow(fake_item).to receive(:save?).and_return(false)
                allow(fake_item).to receive(:save).and_return(false)

                # categories = params["categories"].map{ |category_id| Category.new(category_id, nil)}

                # expect(fake_item).to receive(:categories=).with(categories)
                # expect(fake_item).to receive(:save?)
                expect(fake_item).to receive(:save)
                expect(ItemController.create_item(params)).to eq(false)
            end 
        end

        context 'given parameter with valid name and price' do
            it 'should return false and not save the data' do
                params = {
                    "name" => "yes",
                    "price" => 123
                    # "categories" => [1,2]
                }

                fake_item = double
                allow(Item).to receive(:new).and_return(fake_item)
                allow(fake_item).to receive(:save).and_return(true)

                expect(fake_item).to receive(:save)
                expect(ItemController.create_item(params)).to eq(true)
            end 
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

        context 'given a valid id with empty name and price in the parameter' do
            it 'should return false' do
                params = {
                    "id" => 99,
                    "name" => "",
                    "price" => nil
                }

                fake_item = double
                allow(Item).to receive(:get_item_by_id).and_return(fake_item)
                allow(fake_item).to receive(:update).and_return(false)
                
                expect(fake_item).to receive(:name=).with(params["name"])
                expect(fake_item).to receive(:price=).with(params["price"].to_i)
                expect(fake_item).to receive(:categories=).with([])

                expect(fake_item).to receive(:update)


                expect(ItemController.update(params)).to eq(false)
            end
        end

        context 'given a valid id with valid name and price in the parameter' do
            it 'should return true and updates the data' do
                params = {
                    "id" => 1,
                    "name" => "updated",
                    "price" => 999
                }
                fake_item = double
                allow(Item).to receive(:get_item_by_id).and_return(fake_item)
                allow(fake_item).to receive(:update).and_return(true)
                
                expect(fake_item).to receive(:name=).with(params["name"])
                expect(fake_item).to receive(:price=).with(params["price"].to_i)
                expect(fake_item).to receive(:categories=).with([])

                expect(fake_item).to receive(:update)


                expect(ItemController.update(params)).to eq(true)
            end
        end
    end

    describe '#delete' do
        context 'given no id parameter' do
            it 'should return false' do
                params = {}

                expect(ItemController.delete(params)).to eq(false)
            end
        end

        context 'given invalid id parameter' do
            it 'should return false and does not delete the item' do
                params = {"id"=>12480}
                fake_item = double
                allow(Item).to receive(:get_item_by_id).and_return(nil)

                expect(fake_item).not_to receive(:delete)

                expect(ItemController.delete(params)).to eq(false)
            end
        end

        context 'given valid id parameter' do
            it 'should return true and deletes the item' do
                params = {"id"=>1}
                fake_item = double
                allow(Item).to receive(:get_item_by_id).and_return(fake_item)
                allow(fake_item).to receive(:delete).and_return(true)

                expect(fake_item).to receive(:delete)

                expect(ItemController.delete(params)).to eq(true)
            end
        end
    end
end