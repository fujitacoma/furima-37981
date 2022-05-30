class PurchasesController < ApplicationController
  before_action :set_item
  before_action :move_to_index, only: [:index]


  def index
    @purchase_customer = PurchaseCustomer.new
  end

  def create
    @purchase_customer = PurchaseCustomer.new(purchase_params)
    if @purchase_customer.valid?
      @purchase_customer.save
      redirect_to root_path
    else
      render :index
    end
  end

private

  def purchase_params
    params.require(:purchase_customer).permit(:postcode, :prefecture_id, :city, :block, :building, :phone_number)
          .merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    redirect_to new_user_session_path unless user_signed_in?
    if current_user.id == @item.user_id
      redirect_to root_path
    elsif Purchase.exists?(item_id: @item.id)
      redirect_to root_path
    end
  end
end
