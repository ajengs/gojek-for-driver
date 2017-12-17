class Order < ApplicationRecord
  belongs_to :user
  belongs_to :type
  
  enum status: {
    "Initialized" => "Initialized",
    "Driver Assigned" => "Driver Assigned",
    "Cancelled by System" => "Cancelled by System",
    "Finished" => "Finished"
  }
end
