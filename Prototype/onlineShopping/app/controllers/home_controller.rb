class HomeController < ApplicationController
  def index
    @item_list = Item.all
  end

  def show
    @item = Item.query_with_item_id params[:id]
    @seller = User.find(@item[:owner_id])[:email]
  end
end
