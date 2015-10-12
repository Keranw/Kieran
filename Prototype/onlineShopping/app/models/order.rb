class Order < ActiveRecord::Base
  #update the info of purchased items
  def self.purchase(list, quantity)
    result = []
    list.each do |item_id|
      aim_item = Item.find(item_id.to_i)
      session_temp = nil
      quantity.each do |item_quantity|
        if item_id.to_i.eql?(item_quantity["item_buy"].to_i)
          session_temp = item_quantity
          session_temp["name"] = aim_item[:name]
          session_temp["price"] = aim_item[:price]
        end
      end
      quantity_temp = session_temp["quantity_buy"].to_i
      aim_item[:quantity] = aim_item[:quantity] - quantity_temp
      aim_item.save
      result << session_temp
    end
    return result
  end

  #create an order in the database
  def self.create_order params 
    @order = Order.new
    @order[:buyer] = params["buyer"]
    @order[:items] = params["items"]
    @order[:totalprice] = params["totalprice"]
    @order.save
  end

  #find the order with its id
  def self.list_order id
    @orders = Order.where(:buyer => id)
    return @orders     
  end
end
