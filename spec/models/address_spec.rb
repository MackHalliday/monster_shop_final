require 'rails_helper'

describe Address, type: :model do
  describe "validations" do
    it {should validate_presence_of :address_type}
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zipcode}
  end

  describe "relationships" do
    it {should belong_to :user}
    it {should have_many  :orders}
  end

  describe "methods" do
    it "shipped?" do
      regular_user = User.create!(name: "George Jungle",
                                  email: "junglegeorge@email.com",
                                  password: "Tree123")
      address_1 = regular_user.addresses.create!(address_type: "primary",
                                    name: regular_user.name,
                                    address: "1 Jungle Way",
                                    city: "Jungleopolis",
                                    state: "FL",
                                    zipcode: "77652")

      merchant_shop_1 = create(:merchant, name: "Merchant Shop 1")
        item_1 = merchant_shop_1.items.create!(attributes_for(:item, name: "Item 1", inventory: 10))

      order_1 = Order.create!(status: "packaged", address: address_1)
        item_order_2 = regular_user.item_orders.create!(order: order_1, item: item_1, quantity: 3, price: item_1.price, fulfilled?: true)

    expect(address_1.shipped?).to eq(false)
    end
  end
end
