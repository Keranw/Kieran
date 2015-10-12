class PendingOrder < ActiveRecord::Base
  #create a new pending order in the database
  def self.createPendingOrder order
    @porder = PendingOrder.new
    @porder[:buyer] = order[:buyer]
    @porder[:items] = order[:items]
    @porder[:totalprice] = order[:totalprice]
    @porder[:purchasetime] = order[:created_at].to_s
    @porder.save
  end

  #find the pending order with its id
  def self.pendingOrder id
    @porders = PendingOrder.where(:buyer => id)
    return @porders
  end

  #list all pending orders
  def self.all_orders
    return PendingOrder.all
  end

  #delete the selected pending order
  def self.approve id
    @aim = PendingOrder.find(id.to_i)
    @item_list = eval @aim[:items]
    @item_list.each do |item|
      aim_item = Item.find(item["item_buy"].to_i)
      aim_item[:quantity] += item["quantity_buy"].to_i
      aim_item.save
    end
    PendingOrder.delete(@aim)
  end
end
