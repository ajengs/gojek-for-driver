require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'is valid with external_id, driver_id, type_id, origin, destination, price' do
    expect(create(:order)).to be_valid
  end
end
