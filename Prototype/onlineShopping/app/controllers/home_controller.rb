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
end
