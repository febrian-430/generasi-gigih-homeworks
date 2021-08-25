require "refactoring/version"
require "refactoring/item"
require "refactoring/order"
require "refactoring/order_item"

module Refactoring
  class Error < StandardError; end
  # Your code goes here...

  class OrderItem
    def name
      @item.name
    end
    
    def price
      @item.price
    end

    def type
      @item.type
    end
  end

  class Consumeable < Item
    def returnable?
      false
    end

    def tax_in_percent
      5
    end
  end

  class NonEdible < Item
    def returnable?
      true
    end
  end

  class Book < NonEdible
    def tax_in_percent
      10
    end
  end

  class Electronic < NonEdible
    def tax_in_percent
      15
    end
  end

  class Edible < Consumeable
    def validate_tags(tags)
      ['meat', 'dairy', 'vegetable', 'fruit', 'pastry'].include? tags
    end
  end

  class Food < Edible

  end

  class Drink < Consumeable
    def validate_tags(tags)
      ['dairy', 'vegetable', 'fruit', 'coffee', 'tea'].include? tags
    end
  end

  class Snack < Edible
    
  end

  class Order
    def print_order_summary
      food_items = []
      drink_items = []
      snack_items = []
  
      order_items.each do |order_item|
        case order_item.item.type
        when "FOOD"
          food_items.append(order_item)
        when "DRINK"
          drink_items.append(order_item)
        when "SNACK"
          snack_items.append(order_item)
        else
          raise "item type#{order_item.type} is not supported"
      end

      print "Food items:\n"
      food_items.each do |food_item|
        print "#{food_item.quantity} #{food_item.name}"
      end
      print "Drink items:\n"
      drink_items.each do |drink_item|
        print "#{drink_item.quantity} #{drink_item.item.name}"
      end
      print "Snack items:\n"
      snack_items.each do |snack_item|
        print "#{snack_item.quantity} #{snack_item.item.name}"
      end
    end
  end
end
