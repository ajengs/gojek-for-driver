require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let!(:type) { create(:type) }
  let!(:user) { create(:user) }

  let(:valid_attributes) { attributes_for(:order, type_id: type.id) }

  let(:invalid_attributes) { attributes_for(:invalid_order) }
  let!(:order) { create(:order, user: user) }
  let(:order_id) { order.id }

  let(:valid_session) { {gopartner_user_id: user.id} }

  describe "GET #index" do
    before { get :index, params: {}, session: valid_session }

    it "returns a success response" do
      expect(response).to be_success
    end

    it 'populates an array of all orders' do
      expect(assigns(:orders)).to match_array([order])
    end

    it 'renders the :index template' do
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    before { get :show, params: {id: order.to_param}, session: valid_session}

    it "returns a success response" do
      expect(response).to be_success
    end

    it 'assigns the requested order to @order' do
      expect(assigns(:order)).to eq(order)
    end

    it 'renders the :show template' do
      expect(response).to render_template(:show)
    end
  end
end
