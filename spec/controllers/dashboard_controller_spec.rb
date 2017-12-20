require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let!(:user) { create(:user) }
  let(:valid_session) { {gopartner_user_id: user.id} }

  describe "GET #index" do
    context 'with valid session' do
      before { get :index, params: {}, session: valid_session }

      it "returns a success response" do
        expect(response).to be_success
      end

      it 'renders the :index template' do
        expect(response).to render_template(:index)
      end
    end

    context 'with invalid session' do
      before { get :index, params: {} }

      it "redirects to login page" do
        expect(response).to redirect_to(login_path)
      end

    end
  end

end
