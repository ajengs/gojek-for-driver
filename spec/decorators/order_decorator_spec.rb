require 'rails_helper'

RSpec.describe OrderDecorator, :type => [:decorator, :helper] do
  let(:origin)  { 'Kolla Space Sabang'  }
  let(:destination)  { 'Monas' }

  let(:order) { create(:order, 
                     origin: origin, 
                     destination: destination,
                     price: 1500) }

  let(:decorator) { order.decorate }

  describe '.idr_price' do
    it 'should return price in rupiah' do
      expect(decorator.idr_price).to eq("Rp 1.500,00")
    end
  end

  describe '.order_date' do
    it 'should return created date month name and year' do
      expect(decorator.order_date).to eq(order.created_at.strftime("%d %B %Y"))
    end
  end

end
