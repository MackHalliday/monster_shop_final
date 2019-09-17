class Address < ApplicationRecord
  validates_presence_of :address_type, :name, :address, :city, :state, :zipcode

  belongs_to :user
end
