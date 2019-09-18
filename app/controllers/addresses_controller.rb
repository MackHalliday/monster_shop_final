class AddressesController < ApplicationController

  def new
    @address = Address.new
  end

  def create
    @address = current_user.addresses.create(address_params)

    if @address.save
      redirect_to profile_path
    else
      flash[:error] = @address.errors.full_messages.to_sentence
      redirect_to new_address_path
    end
  end

  def edit
    @address = current_user.addresses.find(params[:id])
  end

  def update
    address = Address.find(params[:id])
    address.update(address_params)
    current_user.reload
    if address.save
      redirect_to profile_path
    else
      flash[:error] = address.errors.full_messages.to_sentence
      redirect_to edit_address_path(address)
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    current_user.reload
    redirect_to profile_path
  end

  private
  def address_params
    params.require(:address).permit(:address_type, :name, :address, :city, :state, :zipcode)
  end
end
