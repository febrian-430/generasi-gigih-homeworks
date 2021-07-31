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
end