require 'rspec'
require './models/item'
require './controllers/category_controller'
require './db/mysql_connector'

describe CategoryController do
    before(:each) do
        @categories = [Category.new(1, "fake"), Category.new(2, "fakee"), Category.new(3, "boom")]
    end

    describe "#create_form" do
        it 'should render the create form' do
            renderer = ERB.new(File.read('./views/category/create.erb'))
            expect(CategoryController.create_form).to eq(renderer.result(binding))
        end
    end

    describe "#create_category" do
        context 'given empty parameter for name' do
            it 'should return false' do
                params = {}
                expect(Category).not_to receive(:new)
                expect(CategoryController.create_category(params)).to eq(false)
            end
        end

        context 'given valid parameter for name' do
            it 'should return true and saves' do
                params = {"name"=> "dummy"}
                
                fake_category = double
                allow(Category).to receive(:new).and_return(fake_category)
                allow(fake_category).to receive(:save).and_return(true)

                expect(fake_category).to receive(:save)
                expect(CategoryController.create_category(params)).to eq(true)
            end
        end
    end

    describe "#all_categories" do
        it 'should render the index category' do
            categories = @categories
            renderer = ERB.new(File.read('./views/category/index.erb'))

            allow(Category).to receive(:all).and_return(categories)

            expect(CategoryController.all_categories).to eq(renderer.result(binding))
        end
    end

    describe "#edit_form" do
        context "given invalid id in the parameter" do
            it 'should render not found page' do
                params = {
                    "id" => 13298
                }
                expect(Category).to receive(:by_id).and_return(nil)

                renderer = ERB.new(File.read("./views/not_found.erb"))
                expect(CategoryController.edit_form(params)).to eq(renderer.result(binding))
            end
        end

        context "given valid id in the parameter" do
            it "should render the edit form" do
                params = {
                    "id" => 1
                }
                category = @categories[0]
                expect(Category).to receive(:by_id).and_return(category)

                renderer = ERB.new(File.read("./views/category/edit.erb"))
                expect(CategoryController.edit_form(params)).to eq(renderer.result(binding))
            end
        end
    end

    describe "#update" do
        context "given valid id in the parameter" do
            it 'should return true and updates' do
                params = {
                        "id" => 1
                    }
                fake_category = double
                allow(Category).to receive(:by_id).and_return(fake_category)
                allow(fake_category).to receive(:update).and_return(true)

                expect(fake_category).to receive(:name=).with(params["name"])
                expect(fake_category).to receive(:update)
                expect(CategoryController.update(params)).to eq(true)
            end
        end

        context "given empty id in the parameter" do
            it 'should render error not found page' do
                params = {}

                fake_category = double("category")
                allow(Category).to receive(:by_id).and_return(nil)

                expect(fake_category).not_to receive(:update)

                renderer = ERB.new(File.read("./views/not_found.erb"))
                expect(CategoryController.update(params)).to eq(renderer.result(binding))
            end
        end

        context "given empty name in the parameter" do
            it 'should return false and does not update' do
                params = {}

                fake_category = double("category")
                allow(Category).to receive(:by_id).and_return(fake_category)
                allow(fake_category).to receive(:update).and_return(false)

                expect(fake_category).to receive(:name=).with(params["name"])
                expect(fake_category).to receive(:update)
                expect(CategoryController.update(params)).to eq(false)
            end
        end
    end

    describe "#delete" do
        context "given empty id in the parameter" do
            it 'should return false' do
                params = {}

                expect(Category).not_to receive(:by_id)
                expect(CategoryController.delete(params)).to eq(false)
            end
        end

        context "given invalid id in the parameter" do
            it 'should return false and does not delete' do
                params = { "id" => 129038 }

                fake_category = double("category")
                allow(Category).to receive(:by_id).and_return(nil)
                allow(fake_category).to receive(:delete).and_return(false)

                expect(Category).to receive(:by_id)
                expect(fake_category).not_to receive(:delete)
            
                renderer = ERB.new(File.read("./views/not_found.erb"))
                expect(CategoryController.delete(params)).to eq(renderer.result(binding))
            end
        end

        context "given valid id in the parameter" do
            it 'should return true and deletes' do
                params = {"id" => 1}

                fake_category = double("category")
                allow(Category).to receive(:by_id).and_return(fake_category)
                allow(fake_category).to receive(:delete).and_return(true)

                expect(Category).to receive(:by_id)
                expect(fake_category).to receive(:delete)
                expect(CategoryController.delete(params)).to eq(true)
            end
        end
    end
end