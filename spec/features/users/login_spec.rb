require 'rails_helper'

RSpec.describe "User Login" do
  before :each do
    @regular_user = User.create!(name: "George Jungle",
                  address: "1 Jungle Way",
                  city: "Jungleopolis",
                  state: "FL",
                  zipcode: "77652",
                  email: "junglegeorge@email.com",
                  password: "Tree123")
    @merchant_user = User.create!(name: "Michael Scott",
                  address: "1725 Slough Ave",
                  city: "Scranton",
                  state: "PA",
                  zipcode: "18501",
                  email: "michael.s@email.com",
                  password: "WorldBestBoss",
                  role: 2)
    @admin_user = User.create!(name: "Leslie Knope",
                  address: "14 Somewhere Ave",
                  city: "Pawnee",
                  state: "IN",
                  zipcode: "18501",
                  email: "recoffice@email.com",
                  password: "Waffles",
                  role: 3)
  end

  it "can log in a regular user" do
    visit "/login"

    fill_in :email, with: @regular_user.email
    fill_in :password, with: @regular_user.password

    click_button "Submit"

    expect(current_path).to eq("/profile")
    expect(page).to have_content("Logged in as #{@regular_user.name}")
  end

  it "can log in a merchant user" do
    visit "/login"

    fill_in :email, with: @merchant_user.email
    fill_in :password, with: @merchant_user.password

    click_button "Submit"

    expect(current_path).to eq("/merchant")
    expect(page).to have_content("Logged in as #{@merchant_user.name}")
  end

  it "can log in an admin user" do
    visit "/login"

    fill_in :email, with: @admin_user.email
    fill_in :password, with: @admin_user.password

    click_button "Submit"

    expect(current_path).to eq("/admin")
    expect(page).to have_content("Logged in as #{@admin_user.name}")
  end

  describe "When a regular user tries to access merchant or admin path" do
    it "should respond with 404 page" do
      visit "/login"

      fill_in :email, with: @regular_user.email
      fill_in :password, with: @regular_user.password

      click_button "Submit"

      visit '/merchant'
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/admin'
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
