require 'rails_helper'

RSpec.describe "Admin_user User Index Page " do
  before :each do
    @admin_user = User.create!(name: "Leslie Knope",
                  email: "recoffice@email.com",
                  password: "Waffles",
                  role: 3)
    @address_1 = create(:address, user: @admin_user)

    @regular_user = User.create!(name: "George Jungle",
                  email: "junglegeorge@email.com",
                  password: "Tree123")
    @address_2 = create(:address, user: @regular_user)

    @merchant_user = User.create!(name: "Michael Scott",
                  email: "michael.s@email.com",
                  password: "WorldBestBoss",
                  role: 2)
    @address_3 = create(:address, user: @merchant_user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
  end

  it "displays pertinent info for all users" do
    visit merchants_path

    within 'nav' do
      click_link "All Users"
    end

    expect(current_path).to eq(admin_users_path)

    within "#user-#{@admin_user.id}" do
      expect(page).to have_link(@admin_user.name)
      expect(page).to have_content(@admin_user.created_at.strftime("%Y-%m-%d"))
      expect(page).to have_content(@admin_user.role)
    end

    within "#user-#{@regular_user.id}" do
      expect(page).to have_link(@regular_user.name)
      expect(page).to have_content(@regular_user.created_at.strftime("%Y-%m-%d"))
      expect(page).to have_content(@regular_user.role)
    end
    within "#user-#{@merchant_user.id}" do
      expect(page).to have_link(@merchant_user.name)
      expect(page).to have_content(@merchant_user.created_at.strftime("%Y-%m-%d"))
      expect(page).to have_content(@merchant_user.role)
    end
  end
end
