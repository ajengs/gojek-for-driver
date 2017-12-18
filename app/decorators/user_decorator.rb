class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    if first_name.blank? && last_name.blank?
      'No name provided.'
    else
      "#{ first_name } #{ last_name }".strip
    end
  end

  def joined_at
    created_at.strftime("%B %Y")
  end

  def idr_gopay
    h.number_to_currency(gopay, unit: "Rp ", delimiter: ".", separator: ",")
  end
end
