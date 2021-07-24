require './models/category.rb'
require 'sinatra'
require 'erb'

class CategoryController

    def self.create_form
        renderer = ERB.new(File.read('./views/category/create.erb'))
        renderer.result(binding)
    end

    def self.create_category(params)
        Category.new(nil, params["name"]).save
    end

    def self.all_categories
        puts "here"
        categories = Category.all
        renderer = ERB.new(File.read('./views/category/index.erb'))
        renderer.result(binding)
    end

    def self.edit_form(params)
        category = Category.by_id(params["id"].to_i)
        puts category.inspect
        ERB.new(File.read("./views/category/edit.erb")).result(binding)
    end
    
    def self.update(params)
        category = Category.by_id(params["id"].to_i)
        category.name = params["name"]
        category.update 
    end

    def self.delete(params)
        category = Category.by_id(params["id"].to_i)
        category.delete
    end
end