class Item < ActiveRecord::Base
  belongs_to :user

  #query function in mapper layer
  def self.query_with_owner_id o_id
    @result =[]
    Item.where("owner_id = #{o_id}").find_each do |item|
      @result << item
    end
    return @result 
  end

  #search item table with the key word and return the result
  def self.search search
    search_condition = "%" + search + "%"
    @result = Item.find_by_sql("SELECT * FROM items WHERE name LIKE'#{search_condition}'
      OR description LIKE'#{search_condition}'")
    return @result
  end

  #delete function in mapper layer
  def self.delete_with_id o_id
    Item.find(o_id).destroy
  end

  #create function in mapper layer
  def self.create_an_item parameters
    @mapped_item = Item.new
    @mapped_item[:name] = parameters[:item][:name]
    @mapped_item[:owner_id] = parameters[:item][:owner_id]
    @mapped_item[:quantity] = parameters[:item][:quantity]
    @mapped_item[:price] = parameters[:item][:price]
    @mapped_item[:description] = parameters[:item][:description]
    @mapped_item.save
  end

  #find an item with its id
  def self.query_with_item_id i_id
    @result = {}
    @aim_item = Item.find(i_id)
    return @aim_item
  end

  #update the info of an item
  def self.edit_an_item parameters
    @mapped_item = Item.find(parameters[:item][:id])
    @mapped_item[:name] = parameters[:item][:name]
    @mapped_item[:price] = parameters[:item][:price]
    @mapped_item[:quantity] = parameters[:item][:quantity]
    @mapped_item[:description] = parameters[:item][:description]
    @mapped_item.save 
  end

end
