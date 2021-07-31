require 'rspec'
require './db/mysql_connector.rb'

describe MySQLDB do
    #im not sure how to test this
    #so i tested this with real db connection
    describe "#transaction" do
        context "when containing a block that is invalid (query) statement" do
            it 'should return false' do
                result = MySQLDB.transaction do |client|
                    client.query("invalid query;")
                    a = 1/0
                end
                expect(result).to eq(false)
            end
        end

        context "when all blocks are valid query statement" do
            it 'should return true' do
                result = MySQLDB.transaction do |client|
                    client.query("select * from items;")
                end
                expect(result).to eq(true)
            end
        end
    end
end