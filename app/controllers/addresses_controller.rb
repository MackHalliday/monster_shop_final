class AddressesController < ApplicationController

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

  private
  def address_params
    params.require(:address).permit(:address_type, :name, :address, :city, :state, :zipcode)
  end
end
