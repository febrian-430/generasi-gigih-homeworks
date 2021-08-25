module Refactoring
  class Order
    attr_reader :order_items

    def calculate_price(voucher, tax, delivery_cost)
      price = 0
  
      order_items.each do |order_item|
        if voucher == true
          if order_item.quantity > 10
            price += (order_item.quantity * order_item.item.price) * 0.8
          elsif order_item.quantity > 5
            price += (order_item.quantity * order_item.item.price) * 0.9
          elsif order_item.quantity > 2
            price += (order_item.quantity * order_item.item.price) * 0.95
          else
        else
          price += order_item.quantity * order_item.item.price
        end
      end
  
      price_after_tax = price + (tax * price)
      total_price = price_after_tax + delivery_cost
    end  

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
          raise "item type#{order_item.item.type} is not supported"
      end

      print "Food items:\n"
      food_items.each do |food_item|
        print "#{food_item.quantity} #{food_item.item.name}"
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
