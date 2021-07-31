require 'rspec'
require 'mysql2'
require './models/item'
require './models/category'

require './db/mysql_connector'

describe Item do
    describe 'validation before database manipulation' do

        before(:each) do
            @item = Item.new(1, "item 1", 123)
        end
        describe '#save?' do
            context 'given valid Item instance with no categories' do
                it 'should return true' do
                    expected = true
                    expect(@item.save?).to eq(expected)
                end
            end

            context 'given an item with no name' do
                it 'should return false' do
                    @item.name = nil
                    expected = false
                    expect(@item.save?).to eq(expected)
                end
            end
        end

        describe '#update?' do
            context 'given a valid item instance' do
                it 'should return true' do
                    expected = true
                    expect(@item.update?).to eq(expected)
                end
            end

            context 'given an item instance with no id' do
                it 'should return true' do
                    @item.id = nil
                    expected = false
                    expect(@item.update?).to eq(expected)
                end
            end

            context 'given an item with empty name' do
                it 'should return false (empty name as nil)' do
                    @item.name = nil
                    expected = false
                    expect(@item.update?).to eq(expected)
                end

                it 'should return false (empty name as empty string)' do
                    @item.name = ''
                    expected = false
                    expect(@item.update?).to eq(expected)
                end
            end

            context 'given an item with nil price' do
                it 'should return false' do
                    @item.price = nil
                    expected = false
                    expect(@item.update?).to eq(expected)
                end
            end
        end

        describe '#delete?' do
            context 'given a valid item' do
                it 'should return true' do
                    expected = true
                    expect(@item.delete?).to eq(expected)
                end
            end

            context 'given an item which only has id attribute supplied' do
                it 'should return true' do
                    @item.name = nil
                    @item.price = nil
                    expected = true
                    expect(@item.delete?).to eq(expected)
                end
            end

            context 'given an item with nil id' do
                it 'should return false' do
                    @item.id = nil
                    expected = false
                    expect(@item.delete?).to eq(false)
                end
            end
        end
    end

    describe 'fetches data from database' do
        describe '#get_all_items' do
            it 'should return all data from database' do
                mock_client = double
                allow(MySQLDB).to receive(:get_client).and_return(mock_client)
                
                expect(Item).to receive(:bind_to_items).with(nil)
                expect(mock_client).to receive(:query).with("select * from items")
                items = Item.get_all_items
            end
        end

        describe '#get_all_items_with_categories' do
            it 'should return the data from database' do
                mock_client = double
                allow(MySQLDB).to receive(:get_client).and_return(mock_client)
                
                expect(Item).to receive(:bind_to_items).with(nil)
                expect(mock_client).to receive(:query)
                .with(
                    "select i.*, c.id as category_id, c.name as category_name
             from items i 
             join item_categories ic on i.id = ic.item_id
             join categories c on c.id = ic.category_id"
                )
                items = Item.get_all_items_with_categories
            end
        end

        describe '#get_item_by_id' do
            context 'given an id that is not in the database' do
                it 'should return nil' do
                    id = -1
                    mock_client = double
                    allow(MySQLDB).to receive(:get_client).and_return(mock_client)
                    
                    expect(Item).to receive(:bind_to_items).with(nil)
                    expect(mock_client).to receive(:query)
                    .with(
                        "select id, name, price
             from items
             where id = #{id}"
                    )
                    items = Item.get_item_by_id(id)
                end
            end

            context 'given an id that is in the database' do
                it 'should return the result with id' do
                    id = -1
                    fake_result = Item.new(1, "123", 123)
                    mock_client = double
                    allow(MySQLDB).to receive(:get_client).and_return(mock_client)
                    allow(Item).to receive(:bind_to_items).and_return([fake_result])
                    allow(Category).to receive(:bind_to_categories).and_return([])

                    expect(Item).to receive(:bind_to_items).with(nil)
                    expect(mock_client).to receive(:query)
                    .with(
                        "select id, name, price
             from items
             where id = #{id}"
                    )
                    expect(mock_client). to receive(:query)
                    item = Item.get_item_by_id(id)
                    expect(item).to eq(fake_result)
                end
            end
        end

        describe '#filter_by_category' do
            it 'should return all data with given category' do
                category_name = "some category"
                mock_client = double
                allow(MySQLDB).to receive(:get_client).and_return(mock_client)
                
                expect(mock_client).to receive(:query)
                .with(
                    "select i.* from items i
            join item_categories ic on ic.item_id = i.id 
            join categories c on c.id = ic.category_id
            where c.name = '#{category_name}'"
                        )
                expect(Item).to receive(:bind_to_items).with(nil)
                Item.filter_by_category(category_name)
            end
        end
    end
    describe 'data manipulation' do
        describe '#save' do
            context 'given an item instance with saveable attribute values' do
                it 'should return true and the data is inserted' do
                    item = Item.new(nil, "item 1", 123)

                    allow(MySQLDB).to receive(:transaction).and_return(true)

                    expect(MySQLDB).to receive(:transaction)
                    successful = item.save
                    expect(successful).to eq(true)
                    
                end
            end

            context 'given instance that doesnt pass the validation' do
                it 'should return false' do
                    item = Item.new(nil, "", nil)
                    allow(item).to receive(:save?).and_return(false)

                    expect(item).to receive(:save?)
                    expect(MySQLDB).not_to receive(:transaction)
                    successful = item.save
                    expect(successful).to eq(false)
                end
            end
        end

        describe '#update' do
            context 'given an item instance with saveable attribute values' do
                it 'should return true and the data is inserted' do
                    item = Item.new(1, "item 2", 123)

                    allow(MySQLDB).to receive(:transaction).and_return(true)
                    allow(Category).to receive(:of_item).and_return([])

                    expect(MySQLDB).to receive(:transaction)
                    successful = item.update
                    expect(successful).to eq(true)
                    
                end
            end

            context 'given instance that doesnt pass the validation' do
                it 'should return false' do
                    item = Item.new(1, "", nil)
                    allow(item).to receive(:update?).and_return(false)

                    expect(item).to receive(:update?)
                    expect(Category).not_to receive(:of_item)
                    expect(MySQLDB).not_to receive(:transaction)

                    successful = item.update
                    expect(successful).to eq(false)
                end
            end
        end

        describe '#delete' do
            context 'given an item with no id' do
                it 'should return false and not delete the data' do
                    item = Item.new(nil, "item 1", 123)

                    mock_client = double
                    allow(MySQLDB).to receive(:get_client).and_return(mock_client)

                    expect(mock_client).not_to receive(:query).with("DELETE FROM items WHERE id = #{item.id}")
                    deleted = item.delete

                    expect(deleted).to eq(false)
                end
            end

            context 'given an item with an id' do
                it 'should return false and not delete the data' do
                    item = Item.new(1, "item 1", 123)

                    mock_client = double
                    allow(MySQLDB).to receive(:get_client).and_return(mock_client)

                    expect(mock_client).to receive(:query).with("DELETE FROM items WHERE id = #{item.id}")
                    deleted = item.delete

                    expect(deleted).to eq(true)
                end
            end
        end
    end
end