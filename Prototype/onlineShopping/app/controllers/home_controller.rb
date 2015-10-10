class HomeController < ApplicationController
  $item_list = []

  def index
    $item_list = Item.all
  end

  def show
    @item = Item.query_with_item_id params[:id]
    @seller = User.find(@item[:owner_id])[:email]
  end

  def search
    $item_list = Item.search params[:search]
    redirect_to home_result_path
  end

  def result
  end

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

  def trolley_clear
    session[:item] = []
    redirect_to home_trolley_path
  end

  def delete_item_in_trolley
    session[:item].each do |item|
      if item["item_buy"].to_s.eql?(params[:id])
        session[:item].delete(item)
      end
    end
    redirect_to home_trolley_path
  end

  def trolley_purchase
    puts "&&&&&&&&&&&&&&"
    #要买的物品的id在params里
    puts params.inspect
    puts "________________"
    #要买的数量在session里
    puts session[:item].inspect
    puts "&&&&&&&&&&&&" 
    redirect_to home_trolley_path
  end
end
