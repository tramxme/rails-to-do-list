class ItemsController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @item = Item.new()
  end

  def create 
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to users_dashboard_path
    else
      render 'new'
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to users_dashboard_path
    else
      render "edit"
    end
  end
  

  def destroy
    @item = Item.find(params[:id])
    if current_user == @item.user
      @item.destroy
      redirect_to users_dashboard_path
    else
      flash[:notice] = "You're not authorized for this action"
    end
  end

  def show
    @item = Item.find(params[:id])
    redirect_to users_dashboard_path
  end

  def index
    redirect_to users_dashboard_path
  end

  private
  def item_params
    params.require(:item).permit(:description, :duedate)
  end
end
