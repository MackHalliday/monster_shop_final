require 'rails_helper'

RSpec.describe "Edit User Addresses" do
  before :each do
    @regular_user = User.create!(name: "George Jungle",
                                email: "junglegeorge@email.com",
                                password: "Tree123")
    @address_1 = Address.create!(address_type: "primary",
                                  name: @regular_user.name,
                                  address: "1 Jungle Way",
                                  city: "Jungleopolis",
                                  state: "FL",
                                  zipcode: "77652",
                                  user: @regular_user)
    @address_2 = Address.create!(address_type: "business",
                                  name: @regular_user.name,
                                  address: "123 Happy St.",
                                  city: "Test City",
                                  state: "CO",
                                  zipcode: "38990",
                                  user: @regular_user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@regular_user)
    visit '/profile'
  end

  it 'can edit user their addresses' do

    within "#address-#{@address_1.id}" do
      click_on "Edit"
    end

    expect(current_path).to eq(edit_users_address_path(@address_1))
    expect(find_field("Address type").value).to eq(@address_1.address_type)
    expect(find_field("Name").value).to eq(@address_1.name)
    expect(find_field("Address").value).to eq(@address_1.address)
    expect(find_field("City").value).to eq(@address_1.city)
    expect(find_field("State").value).to eq(@address_1.state)
    expect(find_field("Zipcode").value).to eq(@address_1.zipcode)

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

    click_on "Update Address"

    expect(current_path).to eq('/profile')


    within "#address-#{@address_1.id}" do
      expect(page).to have_content(address_type)
      expect(page).to have_content(name)
      expect(page).to have_content(address)
      expect(page).to have_content(city)
      expect(page).to have_content(state)
      expect(page).to have_content(zipcode)
    end
  end

  it 'user cannot enter nil information' do

    within "#address-#{@address_1.id}" do
      click_on "Edit"
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

    click_on "Update Address"

    expect(current_path).to eq(edit_users_address_path(@address_1))
    expect(page).to have_content("Address type cannot be blank")
    expect(page).to have_content("Name type cannot be blank")
    expect(page).to have_content("Address type cannot be blank")
    expect(page).to have_content("City type cannot be blank")
    expect(page).to have_content("State type cannot be blank")
    expect(page).to have_content("Zipcode type cannot be blank")
  end
end
