class HomeController < ApplicationController
  $item_list = nil

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
      if itemp["item_buy"].eql?(params[:item][:item_id])
        itemp["quantity_buy"] = itemp["quantity_buy"].to_i + params[:item][:quantity].to_i
        @flag = true
      end
    end
    if @flag == false
      @item_hash = {:item_buy => params[:item][:item_id], :quantity_buy => params[:item][:quantity]}
      session[:item].push @item_hash
      puts session[:item]
    end
    redirect_to root_path
  end

  def trolley
    if !session[:item].blank?
      $item_in_trolley = []
      session[:item].each do |item_temp|
        @item = Item.query_with_item_id item_temp["item_buy"].to_i
        item_temp[:name] = @item[:name]
        item_temp[:total] = @item[:price] * item_temp["quantity_buy"].to_i
        $item_in_trolley<<item_temp
      end
    end
  end

  def delete_item_in_trolley
    redirect_to home_trolley_path
  end
end
