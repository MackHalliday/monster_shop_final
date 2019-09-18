class AddressesController < ApplicationController

  def edit
    @address = current_user.addresses.find(params[:id])
  end

  def update

    address = Address.find(params[:id])
    address.update(address_params)
    address.reload
    redirect_to profile_path
  end

  private
  def address_params
    params.require(:address).permit(:address_type, :name, :address, :city, :state, :zipcode)
  end
end
