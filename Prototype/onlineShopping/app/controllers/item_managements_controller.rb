class ItemManagementsController < ApplicationController
  def item_query
    @items_list = Item.query_with_owner_id current_user.id
  end

  def item_destroy
    Item.delete_with_id params[:id]
    redirect_to item_managements_item_query_path
  end

  def item_show
    @record = Item.query_with_item_id params[:id]
    if !@record[:owner_id].eql?(current_user.id)
      redirect_to item_managements_item_query_path
    else
      flash[:error] = "This item doesn't belong to you!"
    end
  end

  def item_new
    @new_item = Item.new
  end

  def item_create
    Item.create_an_item params
    redirect_to item_managements_item_query_path
  end

  def item_read
    @record = Item.query_with_item_id params[:id]
  end

  def item_edit
    Item.edit_an_item params
    redirect_to item_managements_item_query_path
  end
end
