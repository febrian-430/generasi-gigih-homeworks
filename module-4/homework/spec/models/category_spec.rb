require 'rspec'
require 'mysql2'
require './models/item'
require './models/category'

require './db/mysql_connector'

describe Category do
    describe 'validation' do
        before(:each) do
            @category = Category.new(1, "fake")
        end
        describe '#save?' do
            context 'given an empty name' do
                it 'should return false' do
                    @category.name = ""
                    expect(@category.save?).to eq(false)
                end
            end

            context 'given a nil name' do
                it 'should return false' do
                    @category.name = nil
                    expect(@category.save?).to eq(false)
                end
            end

            context 'given a category with name and empty id' do
                it 'should return true' do
                    @category.id = nil
                    expect(@category.save?).to eq(true)
                end
            end
        end

        describe '#update?' do
            context 'given a nil id' do
                it 'should return false' do
                    @category.id = nil
                    expect(@category.update?).to eq(false)
                end
            end

            context 'given a nil name' do
                it 'should return false' do
                    @category.name = nil
                    expect(@category.update?).to eq(false)
                end
            end

            context 'given a empty name' do
                it 'should return false' do
                    @category.name = ""
                    expect(@category.update?).to eq(false)
                end
            end

            context 'given a valid category' do
                it 'should return true' do
                    expect(@category.update?).to eq(true)
                end
            end
        end

        describe '#delete?' do
            context 'given a nil id' do
                it 'should return false' do
                    @category.id = nil
                    expect(@category.delete?).to eq(false)
                end
            end

            context 'given a non-empty id' do
                it 'should return true' do
                    expect(@category.delete?).to eq(true)
                end
            end
        end
    end

    describe 'fetches data' do
        describe '#all' do
            it 'returns all categories' do
                mock_client = double
                allow(MySQLDB).to receive(:get_client).and_return(mock_client)
                
                expect(mock_client).to receive(:query).with("select * from categories ORDER BY ID ASC")
                expect(Category).to receive(:bind_to_categories).with(nil)
                Category.all
            end
        end

        describe '#by_id' do
            it 'returns a category by id' do
                mock_client = double
                find_id = 1
                fake_category = Category.new(1, 'fake')
                allow(MySQLDB).to receive(:get_client).and_return(mock_client)
                allow(Category).to receive(:bind_to_categories).and_return([fake_category])

                expect(mock_client).to receive(:query).with("select * from categories where id = #{find_id}")
                result = Category.by_id(find_id)

                expect(result.id).to eq(fake_category.id)
            end
        end

        describe '#of_item' do
            it 'returns all categories' do
                mock_client = double
                item_id = 1
                fake_categories = [Category.new(1, 'fake'), Category.new(2, 'fakee')]
                allow(MySQLDB).to receive(:get_client).and_return(mock_client)
                allow(Category).to receive(:bind_to_categories).and_return(fake_categories)

                expect(mock_client).to receive(:query)
                .with(
                    "select c.id, c.name 
            from categories c
            join item_categories ic on ic.category_id = c.id
            where ic.item_id = #{item_id}"
                )
                
                result = Category.of_item(item_id)
                expect(result.length).to eq(fake_categories.length)
            end
        end
    end

    describe 'manipulates data' do
        before(:each) do
            @category = Category.new(1, 'fake')
            @mock_client = double
            allow(MySQLDB).to receive(:get_client).and_return(@mock_client)
        end
        describe '#save' do
            context 'given an invalid instance' do
                it 'should return false and not saved to database' do
                    @category.name = nil

                    expect(@mock_client).not_to receive(:query)
                    expect(@category.save).to eq(false)
                end
            end

            context 'given an valid instance' do
                it 'should return true and save to database' do
                    expect(@mock_client).to receive(:query).with("insert into categories(name) values ('#{@category.name}')")
                    expect(@category.save).to eq(true)
                end
            end
        end

        describe '#update' do
            context 'given an invalid instance' do
                it 'should return false and not updated to database' do
                    @category.id = nil
                    expect(@mock_client).not_to receive(:query)
                    expect(@category.update).to eq(false)
                end
            end

            context 'given an valid instance' do
                it 'should return true and save to database' do
                    expect(@mock_client).to receive(:query).with("update categories set name = '#{@category.name}' where id = #{@category.id}")
                    expect(@category.update).to eq(true)
                end
            end
        end

        describe '#delete' do
            context 'given an invalid instance' do
                it 'should return false and not saved to database' do
                    @category.id = nil
                    expect(@mock_client).not_to receive(:query)
                    expect(@category.delete).to eq(false)
                end
            end

            context 'given an valid instance' do
                it 'should return true and save to database' do
                    expect(@mock_client).to receive(:query).with("delete from categories where id = #{@category.id}")
                    expect(@category.delete).to eq(true)
                end
            end
        end
    end
end