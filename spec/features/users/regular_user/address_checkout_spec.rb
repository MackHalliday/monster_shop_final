require 'rails_helper'

# When a user checks out on the cart show page,
# they will have the ability to choose one of their addresses where they'd like the order shipped.
RSpec.describe "Select address during checkout" do

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
      @item_2 = @merchant_shop_1.items.create!(attributes_for(:item, name: "Item 2", inventory: 10))
  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@regular_user)

  visit item_path(@item_1)
  click_on "Add To Cart"
  visit item_path(@item_2)
  click_on "Add To Cart"

  visit cart_path
  end
  it 'displays shipping addresses' do

    within "#address-#{@address_1.id}" do
      expect(page).to have_content(@address_1.address_type)
    end

    within "#address-#{@address_2.id}" do
      expect(page).to have_content(@address_2.address_type)
    end
  end

  it 'user can checkout using selected address' do
    within "#address-#{@address_1.id}" do
       click_link("Checkout Using this Address")
    end

    expect(current_path).to eq("/orders/#{@address_1.id}")

    within "#address" do
      expect(page).to have_content(@address_1.address_type)
      expect(page).to have_content(@address_1.name)
      expect(page).to have_content(@address_1.address)
      expect(page).to have_content(@address_1.city)
      expect(page).to have_content(@address_1.state)
      expect(page).to have_content(@address_1.zipcode)
    end

    expect(page).to have_button("Submit Order")
  end

  it 'can create a submit a new order' do

    within "#address-#{@address_1.id}" do
       click_link("Checkout Using this Address")
    end

    click_button("Submit Order")

  end
end
