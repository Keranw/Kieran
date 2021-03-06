class HomeController < ApplicationController
  $item_list = []

  #show all the item in the database
  def index
    $item_list = Item.all
  end

  #show detail info about the selected item
  def show
    @item = Item.query_with_item_id params[:id]
    @seller = User.find(@item[:owner_id])[:email]
    @buyer = current_user
  end

  #find the items with the key word
  def search
    $item_list = Item.search params[:search]
    redirect_to home_result_path
  end

  #just list the result, no domain logic here
  def result
  end

  #put the selected item into shopping trolley
  def buy
    @flag = false
    session[:item].each do |itemp|
    # if the item exists in the session, just add the quantity
      if itemp["item_buy"].eql?(params[:item][:item_id])
        itemp["quantity_buy"] = itemp["quantity_buy"].to_i + params[:item][:quantity].to_i
        @flag = true
      end
    end
    # if the item doesn't exist, push the item in the session
    if @flag == false
      @item_hash = {"item_buy" => params[:item][:item_id], "quantity_buy" => params[:item][:quantity]}
      session[:item].push @item_hash
      puts session[:item]
    end
    redirect_to root_path
  end

  #list all the items in the shopping trolley
  def trolley
    #the list of items in the trolley to store returned items
    $item_in_trolley = []
    if !session[:item].blank?
      #get all items in the trolley from database with info in session
      session[:item].each do |item_temp|
        @item_temp = item_temp
        @item = Item.query_with_item_id item_temp["item_buy"].to_i
        $item_in_trolley<<@item
      end
    else
      #no domain logic need here
    end
  end

  #delete all the items in the shopping trolley
  def trolley_clear
    session[:item] = []
    redirect_to home_trolley_path
  end

  #delete selected item in the shopping trolley
  def delete_item_in_trolley
    session[:item].each do |item|
      if item["item_buy"].to_s.eql?(params[:id])
        session[:item].delete(item)
      end
    end
    redirect_to home_trolley_path
  end

  #purchase selected items in the shopping trolley
  def trolley_purchase
    @order_info = {}
    @totalprice = 0
    @flag = true
    params["item_id"].each do |aim_item_info|  
      aim_item = Item.find(aim_item_info.to_i)
      if aim_item[:owner_id].eql?current_user[:id]
        @flag = false
        flash[:error] = "You can't buy your own item #{aim_item[:name]}, please modify your order."
      end
      aim_item_session = nil
      session[:item].each do |temp|
        if aim_item[:id].eql?(temp["item_buy"].to_i)
          aim_item_session = temp
        end
      end
      aim_item_quantity = aim_item_session["quantity_buy"].to_i
      # if a buyer wants to get more than the seller has, the system throws an error
      if aim_item[:quantity] < aim_item_quantity
        flash[:error] = "Only #{aim_item[:quantity]} #{aim_item[:name]} left, please modify your order."
        @flag = false
      else
        @totalprice = @totalprice + aim_item[:price] * aim_item_quantity
      end
    end

    if @flag
    ##########################################################
      @items = Order.purchase(params["item_id"], session[:item])
      @order_info["buyer"] = current_user[:id]
      @order_info["items"] = @items
      @order_info["totalprice"] = @totalprice
      Order.create_order @order_info
      flash[:success] = "A new order has been created!"
      #delete purchased items in the session#################
      params["item_id"].each do |delete_aim|
        session[:item].each do |delete_session|
          if delete_session["item_buy"].to_i.eql?(delete_aim.to_i)
            session[:item].delete(delete_session)
          end
        end
      end
    #######################################################
    end
    redirect_to home_trolley_path
  end
end
