class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :phone, :license_plate, :rating, :current_location
  belongs_to :type
end
