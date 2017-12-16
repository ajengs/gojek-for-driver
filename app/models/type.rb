class Type < ApplicationRecord
  has_many :users
  has_many :orders
  validates :name, :base_fare, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :base_fare, numericality: { greater_than_or_equal_to: 0 }
end
