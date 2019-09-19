class Address < ApplicationRecord
  validates_presence_of :address_type, :name, :address, :city, :state, :zipcode

  belongs_to :user
  has_many :orders

  def shipped?
    self.orders.any? { |order| order.status == "shipped" }
  end
end
