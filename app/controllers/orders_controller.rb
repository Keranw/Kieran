class OrdersController < ApplicationController
  #list orders belong to current user
  def my_orders
    @my_orders = Order.list_order current_user[:id]
  end

  #quest for cancel an order
  def ask_cancel
    @pending_order = Order.find(params[:format].to_i)
    PendingOrder.createPendingOrder @pending_order
    Order.delete(@pending_order)
    redirect_to order_my_orders_path
  end

  #list pending orders belong to current user
  def pending_orders
    @pending_orders = PendingOrder.pendingOrder current_user[:id].to_i
  end

  #list all pending orders
  def order_management
    @pending_orders = PendingOrder.all_orders
  end

  #approve cancel of selected item
  def approve_cancel
    @aim_order = PendingOrder.approve params[:format]
    redirect_to order_order_management_path
  end
end
