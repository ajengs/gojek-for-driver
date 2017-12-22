# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.delete_all
# Type.delete_all

# Type.create!(
#   [
#     {
#       name: "Go-Ride"
#     },
#     {
#       name: "Go-Car"
#     }
#   ]
# )

User.create!(
  [
    {
      email: "malfoy@driver.com", 
      first_name: "Draco", 
      last_name: "Malfoy", 
      password: '12345678', 
      password_confirmation:'12345678', 
      phone:'08786768665', 
      license_plate:'B7878DD', 
      type_id: 1
    },
    {
      email: "crabbe@driver.com", 
      first_name: "Vincent", 
      last_name: "Crabbe", 
      password: '12345678', 
      password_confirmation:'12345678', 
      phone:'08676865655', 
      license_plate:'F7878DD',
      type_id: 1
    },
    {
      email: "goyle@driver.com", 
      first_name: "Gregory", 
      last_name: "Goyle", 
      password: '12345678', 
      password_confirmation:'12345678', 
      phone:'08967757567', 
      license_plate:'B7848SS', 
      type_id: 2
    }
  ]
)
