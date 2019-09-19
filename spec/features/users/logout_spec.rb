
require 'rails_helper'

RSpec.describe "User Logout" do
  before :each do
    @regular_user = User.create!(name: "George Jungle",
                  email: "junglegeorge@email.com",
                  password: "Tree123")
    @address_1 = create(:address, user: @regular_user)

    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)

    @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
  end

  it "can logout user and redirect to the home page with a flash messages indicating that I am logged out and all shopping cart items are deleted" do
    visit "/login"

    fill_in :email, with: @regular_user.email
    fill_in :password, with: @regular_user.password

    click_button "Submit"

    visit item_path(@paper)
      click_on "Add To Cart"

    within 'nav' do
      click_link 'Logout'
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You have been logged out!")
    expect(page).to have_content("Cart: 0")
  end
end
