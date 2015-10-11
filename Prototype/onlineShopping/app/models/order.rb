class Order < ActiveRecord::Base
  def self.create_order params
    @order = Order.new
    @order[:buyer] = params["buyer"]
    @order[:items] = params["items"]
    @order[:totalprice] = params["totalprice"]
    @order.save
  end

  def self.list_order id
    @orders = Order.where(:buyer => id)
    return @orders     
  end
end
