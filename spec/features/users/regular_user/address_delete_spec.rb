require 'rails_helper'

RSpec.describe "Add New User Addresses" do

  before :each do
    @regular_user = User.create!(name: "George Jungle",
                                email: "junglegeorge@email.com",
                                password: "Tree123")
    @address_1 = @regular_user.addresses.create!(address_type: "primary",
                                  name: @regular_user.name,
                                  address: "1 Jungle Way",
                                  city: "Jungleopolis",
                                  state: "FL",
                                  zipcode: "77652")
    @address_2 = @regular_user.addresses.create!(address_type: "school",
                                  name: @regular_user.name,
                                  address: "123 Happy St",
                                  city: "Test City",
                                  state: "CO",
                                  zipcode: "88405")

    @merchant_shop_1 = create(:merchant, name: "Merchant Shop 1")
      @item_1 = @merchant_shop_1.items.create!(attributes_for(:item, name: "Item 1", inventory: 10))

    @order_1 = Order.create!(status: "shipped", address: @address_1)
      @item_order_1 = @regular_user.item_orders.create!(order: @order_1, item: @item_1, quantity: 2, price: @item_1.price, fulfilled?: true)

    @order_2 = Order.create!(status: "packaged", address: @address_2)
      @item_order_2 = @regular_user.item_orders.create!(order: @order_2, item: @item_1, quantity: 3, price: @item_1.price, fulfilled?: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@regular_user)
    visit profile_path
  end
  it 'can add new address' do

    within "#address-#{@address_2.id}" do
      click_on "Delete"
    end

    expect(current_path).to eq(profile_path)

    within "#address" do
      expect(page).to_not have_css("#address-#{@address_2.id}")
      expect(page).to_not have_content(@address_2.address_type)
      expect(page).to_not have_content(@address_2.address)
      expect(page).to_not have_content(@address_2.city)
      expect(page).to_not have_content(@address_2.state)
      expect(page).to_not have_content(@address_2.zipcode)
    end
  end

  it "address cannot be deleted or changed if it's been used in a shipped order" do


    within "#address-#{@address_1.id}" do
      click_on "Delete"
    end

    within "#address-#{@address_1.id}" do
      expect(page).to have_content(@address_1.address_type)
      expect(page).to have_content(@address_1.address)
      expect(page).to have_content(@address_1.city)
      expect(page).to have_content(@address_1.state)
      expect(page).to have_content(@address_1.zipcode)
    end

    expect(page).to have_content("Address cannot be deleted.")
  end
end
