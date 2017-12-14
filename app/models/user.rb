class User < ApplicationRecord
  has_secure_password
  
  belongs_to :type

  validates :email, :first_name, :last_name, :phone, :license_plate, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: {
    with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
    message: 'format is invalid'
  }
  validates :phone, uniqueness: true, length: { maximum: 12 }, numericality: true
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 8 }, allow_blank: true
  validates :license_plate, uniqueness: { case_sensitive: false }
  validates :gopay, numericality: { greater_than_or_equal_to: 0 }
  
  GMAPS = GoogleMapsService::Client.new(key: 'AIzaSyDBu0E_x067mvWLpmOSdRsnhYL9euWiczk')
  
  def set_location(location)
    location_geocode = GMAPS.geocode(location)

    if !location_geocode.nil? && location_geocode.empty?
      errors.add(:current_location, "address not found")
      false
    else
      self.update(current_location: location)
    end
  end
end
