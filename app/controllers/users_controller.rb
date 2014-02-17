class UsersController < ApplicationController

  def profile

  end

  def dashboard
    @items = Item.all
    @item_list = []
    @items.each do |item|
      if item.user == current_user
        @item_list.push(item)
      end
    end
    @item_list
  end


end
