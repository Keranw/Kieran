class HomeController < ApplicationController
  def index
    @item_list = Item.all
  end
end
