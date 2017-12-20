class Order < ApplicationRecord
  belongs_to :user
  belongs_to :type
  after_save :pay_with_gopay, unless: :skip_callbacks  

  enum status: {
    "Initialized" => "Initialized",
    "Cancelled by System" => "Cancelled by System",
    "Assigned" => "Assigned"
  }

  enum payment_type: {
    "Cash" => "Cash",
    "Go-Pay" => "Go-Pay"
  }
  # after_commit { OrderRelayJob.perform_later(self) }
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
      if self.status == "Assigned"
        response = GopayService.add(user, self.price, self)
      elsif self.status == "Cancelled by System"
        response = GopayService.substract(user, self.price, self)
      end

      if response[:status] == 'OK'
        user.update(gopay: response[:account][:amount])
      elsif !response.nil?
        self.update_columns(status: "Cancelled by System", updated_at: Time.now)
      end
    end
end
