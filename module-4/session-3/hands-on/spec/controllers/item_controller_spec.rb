require 'rspec'
require './controllers/item_controller'

describe ItemController do
    describe '#create_form' do
        it 'renders create item form' do
            categories = Category.all
            renderer = ERB.new(File.read("./views/item/create.erb"))

            expect(ItemController.create_form).to eq(renderer.result(binding))
        end
    end
end