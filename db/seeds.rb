# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Type.delete_all

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
  [
    {
      email: "panggah@koko.com", 
      first_name: "panggah", 
      last_name: "baskoro", 
      password: '12345678', 
      password_confirmation:'12345678', 
      phone:'0898', 
      license_plate:'b7878dd', 
      type_id: 1,
      current_location: 'Kolla Space Sabang'
    },
    {
      email: "ajeng@koko.com", 
      first_name: "ajeng", 
      last_name: "sugiarti", 
      password: '12345678', 
      password_confirmation:'12345678', 
      phone:'0811', 
      license_plate:'f7878dd', 
      type_id: 1,
      current_location: 'Monas'
    },
    {
      email: "nanda@koko.com", 
      first_name: "nanda", 
      last_name: "ramdhani", 
      password: '12345678', 
      password_confirmation:'12345678', 
      phone:'0878', 
      license_plate:'f7878ss', 
      type_id: 1,
      current_location: 'Stasiun Gondangdia'
    }
  ]
)
