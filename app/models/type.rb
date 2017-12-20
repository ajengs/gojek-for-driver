class Type < ApplicationRecord
  has_many :users
  has_many :orders
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
