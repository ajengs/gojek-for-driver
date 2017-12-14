# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Type.create!(
  [
    {
      name: "Go-Ride",
      base_fare: 1500
    },
    {
      name: "Go-Car",
      base_fare: 2500
    }
  ]
)

User.create!(
  email: "panggah@koko.com", 
  first_name: "panggah", 
  last_name: "baskoro", 
  password: '12345678', 
  password_confirmation:'12345678', 
  phone:'0898', 
  license_plate:'b7878dd', 
  type_id: 1
)
