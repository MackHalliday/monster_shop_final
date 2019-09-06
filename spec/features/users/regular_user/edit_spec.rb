require 'rails_helper'

RSpec.describe "User Profile" do
  before :each do
    @regular_user = User.create!(name: "George Jungle",
                  address: "1 Jungle Way",
                  city: "Jungleopolis",
                  state: "FL",
                  zipcode: "77652",
                  email: "junglegeorge@email.com",
                  password: "Tree123")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@regular_user)
    visit '/profile'
  end

  it 'can edit user information' do

    within "#user-profile-actions" do
      click_link("Edit Profile")
    end

    expect(current_path).to eq("/profile/edit")

    fill_in :name, with: "Adam Smith"
    fill_in :address, with: "1234 Happy St"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zipcode, with: "80204"
    fill_in :email, with: "chicken@email.com"

    click_button "Update Profile"

    expect(current_path).to eq("/profile")
    expect(page).to have_content("Adam Smith")
    expect(page).to have_content("1234 Happy St")
    expect(page).to have_content("Denver")
    expect(page).to have_content("CO")
    expect(page).to have_content("chicken@email.com")
    expect(page).to have_content("Your profile has been updated")
  end

  it 'user cannot enter nil information' do

    within "#user-profile-actions" do
      click_link("Edit Profile")
    end

    fill_in :name, with: "Adam Smith"
    fill_in :address, with: "1234 Happy St"
    fill_in :city, with: ""
    fill_in :state, with: "CO"
    fill_in :zipcode, with: ""
    fill_in :email, with: "chicken@email.com"

    click_button "Update Profile"

    expect(current_path).to eq("/profile/edit")
    expect(page).to have_content("City can't be blank and Zipcode can't be blank")
  end

  it 'user cannot enter invalid email' do
    within "#user-profile-actions" do
      click_link("Edit Profile")
    end

    fill_in :name, with: "Adam Smith"
    fill_in :address, with: "1234 Happy St"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zipcode, with: "80205"
    fill_in :email, with: "waffle"

    click_button "Update Profile"

    expect(current_path).to eq("/profile/edit")
    expect(page).to have_content("Email is invalid")
  end

  it "user can edit password" do
    expect(page).to have_link("")

    within "#user-profile-actions" do
      click_link("Edit Password")
    end

    expect(current_path).to eq("/profile/edit_password")

    fill_in :password, with: "apple123"
    fill_in :password_confirmation, with: "apple123"
    click_on "Update"

    expect(current_path).to eq("/profile")
    expect(page).to have_content("Your password has been updated")

    click_link "Logout"

    visit '/login'

    fill_in :email, with: "junglegeorge@email.com"
    fill_in :password, with: "Tree123"
    click_on "Submit"

    expect(page).to have_content("Please enter valid user information")
  end
end
