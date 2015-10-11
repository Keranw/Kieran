class OrdersController < ApplicationController
  def my_orders
    @my_orders = Order.list_order current_user[:id]
  end

  def ask_cancel
    @pending_order = Order.find(params[:format].to_i)
    PendingOrder.createPendingOrder @pending_order
    Order.delete(@pending_order)
    redirect_to order_my_orders_path
  end

  def pending_orders
    @pending_orders = PendingOrder.pendingOrder current_user[:id].to_i
  end

  def order_management
    @pending_orders = PendingOrder.all_orders
  end

  def approve_cancel
    @aim_order = PendingOrder.approve params[:format]
    redirect_to order_order_management_path
  end
end
