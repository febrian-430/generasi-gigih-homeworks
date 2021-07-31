require 'rspec'
require './db/mysql_connector.rb'

describe MySQLDB do
    describe "#transaction" do
        context "when containing a block that is invalid query statement" do
            it 'should return true' do
            end
        end

        context "when a block is valid query statement" do
            it 'should return false' do
            end
        end
    end
end