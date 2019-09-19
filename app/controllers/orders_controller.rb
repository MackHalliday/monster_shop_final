class OrdersController <ApplicationController

  def new
    @user = current_user
    @address = Address.find(params[:address_id])
    @order = Order.new
  end

  def cancel
    order = Order.find(params[:id])
    order.cancel_order
    order.update(status: 3)
    order.save

    flash[:success] = "Your order has been cancelled"
    redirect_to "/profile"
  end

  def create
    user = current_user
    address = Address.find(params[:address])
    order = Order.create(address: address)

    cart.items.each do |item,quantity|
      user.item_orders.create({
        order: order,
        item: item,
        quantity: quantity,
        price: item.price
        })
    end

    session.delete(:cart)
    flash[:order] = "Your order has been created!"
    redirect_to "/profile/orders"
  end
end
