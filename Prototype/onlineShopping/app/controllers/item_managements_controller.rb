class ItemManagementsController < ApplicationController
  #find items belong to current user
  def item_query
    @items_list = Item.query_with_owner_id current_user.id
  end

  #delete one of the item
  def item_destroy
    Item.delete_with_id params[:id]
    redirect_to item_managements_item_query_path
  end

  #show detail info of a selected item (editable)
  def item_show
    @record = Item.query_with_item_id params[:id]
    if @record[:owner_id].eql?(current_user.id)
    else
      flash[:error] = "This item doesn't belong to you!"
      redirect_to root_path
    end
  end

  #create a new item
  def item_new
    @new_item = Item.new
  end

  #save the params in the new created item
  def item_create
    Item.create_an_item params
    redirect_to item_managements_item_query_path
  end

  #show detail info of a selected item (can't edit)
  def item_read
    @record = Item.query_with_item_id params[:id]
    if @record[:owner_id].eql?(current_user.id)
    else
      flash[:error] = "This item doesn't belong to you!"
      redirect_to root_path
    end
  end

  #udpate the info of an item
  def item_edit
    Item.edit_an_item params
    redirect_to item_managements_item_query_path
  end
end
