require 'rails_helper'

RSpec.describe "Admin Users" do
  before :each do
    @admin_user = User.create!(name: "Leslie Knope",
                  address: "14 Somewhere Ave",
                  city: "Pawnee",
                  state: "IN",
                  zipcode: "18501",
                  email: "recoffice@email.com",
                  password: "Waffles",
                  role: 3)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
  end

  it "cannot access merchant or cart paths" do
    visit '/merchant'
    expect(page).to have_content("The page you were looking for doesn't exist.")

    visit '/cart'
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
