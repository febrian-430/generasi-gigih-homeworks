require "refactoring/version"
require "refactoring/item"
require "refactoring/order"
require "refactoring/order_item"

module Refactoring
  class Error < StandardError; end
  # Your code goes here...
  class Item
    def returnable?
      ['BOOK', 'ELECTRONIC'].include?(@type)
    end
  end

  class Order

    def get_raw_subtotal(order_item)
      return order_item.quantity * order_item.item.price
    end

    def discount_factor_in_percent(qty)
      case
        when qty > 10
          80
        when qty > 5
          90
        when qty > 2
          95
        else 
          100
      end
    end

    def get_voucher_discounted_subtotal(order_item)
      discount_factor = discount_factor_in_percent(order_item.quantity)/100
      return get_raw_subtotal(order_item) * discount_factor
    end

    def get_subtotal(voucher, order_item)
      return get_voucher_discounted_subtotal(order_item) if voucher
      get_raw_subtotal(order_item)
    end

    def taxed_price(price, tax)
      return price + (price*tax)
    end

    def total_price(price, delivery_cost)
      price_after_tax = taxed_price(price, tax)
      return price_after_tax + delivery_cost
    end

    def calculate_price(voucher, tax, delivery_cost)
      price = 0
  
      order_items.each do |order_item|
        price += get_subtotal(voucher, order_item)
      end
  
      total_price = total_price(price, tax, delivery_cost)
    end

    def filter_by_type(order_items, type_to_filter)
      filtered_items = order_items.select {
        |order_item|
        order_items.item.type == type_to_filter
      }
      filtered_items
    end

    def 

    def print_order_items(order_items)
      order_items.each do |order_item|
        print "#{order_item.quantity} #{order_item.item.name}"
      end
    end

    def print_order_summary
      

      # order_items.each do |order_item|
      #   case order_item.item.type
      #   when "FOOD"
      #     food_items.append(order_item)
      #   when "DRINK"
      #     drink_items.append(order_item)
      #   when "SNACK"
      #     snack_items.append(order_item)
      #   else
      #     raise "item type#{order_item.item.type} is not supported"
      #   end
      # end
      
      food_items = filter_by_type(order_items, "FOOD")
      drink_items = filter_by_type(order_items, "DRINK")
      snack_items = filter_by_type(order_items, "SNACK")

      print "Food items:\n"
      print_order_items(food_items)

      print "Drink items:\n"
      print_order_items(drink_items)
      
      print "Snack items:\n"
      print_order_items(snack_items)
      
    end 
  end
end
