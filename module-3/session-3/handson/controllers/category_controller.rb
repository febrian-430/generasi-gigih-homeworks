require './models/category.rb'
require 'sinatra'
require 'erb'

class CategoryController

    def self.category_form
        renderer = ERB.new(File.read('./views/category_create.erb'))
        renderer.result(binding)
    end

    def self.create_category(param)
        true if Category.new(nil, param["name"]).save
        false
    end

    def self.all_categories
        categories = Category.all
        categories
    end
end