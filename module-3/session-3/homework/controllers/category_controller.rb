require './models/category.rb'
require 'sinatra'
require 'erb'

class CategoryController

    def self.category_form
        renderer = ERB.new(File.read('./views/category_create.erb'))
        renderer.result(binding)
    end

    def self.create_category(param)
        Category.new(nil, param["name"]).save
    end

    def self.all_categories
        puts "here"
        categories = Category.all
        renderer = ERB.new(File.read('./views/category_index.erb'))
        renderer.result(binding)
    end

    
end