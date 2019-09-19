require 'rails_helper'

RSpec.describe "Merchant Users" do
  before :each do
    @merchant_user = User.create!(name: "Michael Scott",
                  email: "michael.s@email.com",
                  password: "WorldBestBoss",
                  role: 2)
    @address_1 = create(:address, user: @merchant_user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)
  end

  it "cannot access admin paths" do
    visit admin_path
    expect(page).to have_content("The page you were looking for doesn't exist.")

    visit admin_users_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
