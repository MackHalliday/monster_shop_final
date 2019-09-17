class Address < ApplicationRecord
  validates_presence_of :type, :name, :address, :city, :state, :zipcode

  belongs_to :user
end
