require 'rails_helper'

RSpec.describe "Admin_user User Index Page " do
  before :each do
    @merchant_1 = Merchant.create(name: "Brian's Bike Shop",
                  address: '123 Bike Rd.',
                  city: 'Richmond',
                  state: 'VA',
                  zip: 80203)
    @admin_user = User.create!(name: "Leslie Knope",
                  email: "recoffice@email.com",
                  password: "Waffles",
                  role: 3,
                  merchant: @merchant_1)
    @address_1 = create(:address, user: @admin_user)

    @regular_user = User.create!(name: "George Jungle",
                  email: "junglegeorge@email.com",
                  password: "Tree123")
    @address_2 = create(:address, user: @regular_user)

    @merchant_user = User.create!(name: "Michael Scott",
                  email: "michael.s@email.com",
                  password: "WorldBestBoss",
                  role: 2,
                  merchant: @merchant_1)
    @address_3 = create(:address, user: @merchant_user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
  end

  it "displays pertinent info for the specified user" do
    visit admin_users_path

    click_link(@regular_user.name)

    expect(current_path).to eq(admin_user_path(@regular_user))

    within "#user-info-#{@regular_user.id}" do
      expect(page).to have_content(@regular_user.name)
      expect(page).to have_content(@regular_user.email)
    end

    expect(page).to_not have_link("Edit Profile")

    visit admin_users_path

    click_link(@merchant_user.name)

    expect(current_path).to eq(admin_user_path(@merchant_user))

    within "#user-info-#{@merchant_user.id}" do
      expect(page).to have_content(@merchant_user.name)
      expect(page).to have_content(@merchant_user.email)
    end

    expect(page).to_not have_link("Edit Profile")
  end
end
