require './models/category.rb'
require 'sinatra'
require 'erb'

class CategoryController

    def self.create_form
        renderer = ERB.new(File.read('./views/category/create.erb'))
        renderer.result(binding)
    end

    def self.create_category(params)
        if !params["name"]
            return false
        end
        Category.new(nil, params["name"]).save
    end

    def self.all_categories
        categories = Category.all
        renderer = ERB.new(File.read('./views/category/index.erb'))
        renderer.result(binding)
    end

    def self.edit_form(params)
        category = Category.by_id(params["id"].to_i)
        if !category
            ERB.new(File.read("./views/not_found.erb")).result(binding)
        else
            ERB.new(File.read("./views/category/edit.erb")).result(binding)
        end
    end
    
    def self.update(params)
        category = Category.by_id(params["id"].to_i)
        if !category
            ERB.new(File.read("./views/not_found.erb")).result(binding)
        else
            category.name = params["name"]
            category.update 
        end
    end

    def self.delete(params)
        if !params["id"]
            return false
        end
        category = Category.by_id(params["id"].to_i)
        if !category
            return ERB.new(File.read("./views/not_found.erb")).result(binding)
        end
        return category.delete
    end
end