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
    @mapped_item.save
  end

  def self.query_with_item_id i_id
    @result = {}
    @aim_item = Item.find(i_id)
    return @aim_item
  end

  def self.edit_an_item parameters
    @aim_item = Item.find(parameters[:item][:id])
    @aim_item[:name] = parameters[:item][:name]
    @aim_item[:price] = parameters[:item][:price]
    @aim_item[:quantity] = parameters[:item][:quantity]
    @aim_item.save 
  end

end
