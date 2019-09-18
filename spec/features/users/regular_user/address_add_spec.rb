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

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@regular_user)
    visit '/profile'
  end
  it 'can add new address' do

    within "#address" do
      click_on "Add New Address"
    end

    expect(current_path).to eq(new_address_path)

    address_type = "school"
    name = "Adam Smith"
    address = "123 West St"
    city = "New City"
    state = "IL"
    zipcode = "80405"

    fill_in 'Address type', with: address_type
    fill_in 'Name', with: name
    fill_in 'Address', with: address
    fill_in 'City', with: city
    fill_in 'State', with: state
    fill_in 'Zipcode', with: zipcode

    click_on "Add New Address"

    expect(current_path).to eq('/profile')

    within "#address-#{@regular_user.addresses.last.id}" do
      expect(page).to have_content(address_type)
      expect(page).to have_content(name)
      expect(page).to have_content(address)
      expect(page).to have_content(city)
      expect(page).to have_content(state)
      expect(page).to have_content(zipcode)
    end
  end

  it 'new address cannot have nil values' do

    within "#address" do
      click_on "Add New Address"
    end

    address_type = ""
    name = ""
    address = ""
    city = ""
    state = ""
    zipcode = ""

    fill_in 'Address type', with: address_type
    fill_in 'Name', with: name
    fill_in 'Address', with: address
    fill_in 'City', with: city
    fill_in 'State', with: state
    fill_in 'Zipcode', with: zipcode

    click_on "Add New Address"

    expect(current_path).to eq(new_address_path)
    expect(page).to have_content("Address type can't be blank")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Address can't be blank")
    expect(page).to have_content("City can't be blank")
    expect(page).to have_content("State can't be blank")
    expect(page).to have_content("Zipcode can't be blank")
  end
end
