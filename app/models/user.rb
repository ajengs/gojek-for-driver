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
  
  geocoded_by :current_location
  
  def set_location(location)
    return false if location_not_empty(location) || location_unchanged(location)
    
    self.current_location = location
    location_geocode = geocode
    
    return false if location_not_found(location_geocode)
    self.save
    # self.update(current_location: location, latitude: location_geocode[0], longitude: location_geocode[1])
  end

  private
    def location_not_empty(location)
      if !location.present? || location.nil? || location.empty?
        errors.add(:current_location, "can't be blank")
      end
    end

    def location_unchanged(location)
      if location == self.current_location
        errors.add(:current_location, "is not changed")
      end
    end

    def location_not_found(geolocation)
      if geolocation.nil?
        errors.add(:current_location, "address not found")
      end
    end
end
