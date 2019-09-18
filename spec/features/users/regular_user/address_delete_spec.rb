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
end
