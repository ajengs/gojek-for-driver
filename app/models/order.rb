class Order < ApplicationRecord
  belongs_to :user
  belongs_to :type
  after_save :pay_with_gopay, unless: :skip_callbacks  

  enum status: {
    "Initialized" => "Initialized",
    "Driver Assigned" => "Driver Assigned",
    "Cancelled by System" => "Cancelled by System"
  }

  enum payment_type: {
    "Cash" => "Cash",
    "Go-Pay" => "Go-Pay",
    "Credit Card" => "Credit Card"
  }
  after_commit { OrderRelayJob.perform_later(self) }
  private
    def pay_with_gopay
      if self.payment_type == "Go-Pay"
        begin
          update_gopay
        rescue Errno::ECONNREFUSED => e
          self.update_columns(status: "Cancelled by System", updated_at: Time.now)
        end
      end
    end

    def update_gopay
      if self.status == "Initialized"
        response = GopayService.add(user, self.price)
      elsif self.status == "Cancelled by System"
        response = GopayService.substract(user, self.price)
      end

      if response[:Status] == 'OK'
        user.update(gopay: response[:Account][:Amount])
      else
        self.update_columns(status: "Cancelled by System", updated_at: Time.now)
      end
    end
end
