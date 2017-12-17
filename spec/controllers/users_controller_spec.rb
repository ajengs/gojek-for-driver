require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:type) { create(:type) }
  let!(:user) { create(:user) }
  let(:valid_attributes) {
    attributes_for(:user, type_id: type.id)
  }

  let(:invalid_attributes) {
    attributes_for(:invalid_user)
  }

  let(:valid_session) { {gopartner_user_id: user.id} }

  describe "GET #index" do
    it "returns a success response" do
      user = User.create! valid_attributes
      get :index, params: {id: user.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      user = User.create! valid_attributes
      get :edit, params: {id: user.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: {user: valid_attributes}, session: valid_session
        }.to change(User, :count).by(1)
      end

      it "redirects to the created user" do
        post :create, params: {user: valid_attributes}, session: valid_session
        expect(response).to redirect_to(login_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {user: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        attributes_for(:user, first_name: 'Ajeng')
      }

      it "updates the requested user" do
        put :update, params: {id: user.to_param, user: new_attributes}, session: valid_session
        user.reload
        expect(user.first_name).to eq('Ajeng')
      end

      it "redirects to the user" do
        put :update, params: {id: user.to_param, user: valid_attributes}, session: valid_session
        expect(response).to redirect_to(user_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: {id: user.to_param, user: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'GET #location' do
    before { get :edit_location, params: { id: user }, session: valid_session }
    it 'assigns the requested user to @user' do
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the :edit_location template' do
      expect(response).to render_template(:edit_location)
    end
  end

  describe 'PUT #set_location' do
    context 'with valid location' do
      before { put :set_location, params: { id: user, location: 'Kolla Space Sabang' }, session: valid_session }

      it "changes user's location in the database" do
        user.reload
        expect(user.current_location).to eq('Kolla Space Sabang')
      end

      it 'redirect to the user' do
        expect(response).to redirect_to(user_path)
      end
    end

    context 'with invalid location' do
      before { put :set_location, params: { id: user, location: 'xxsd' }, session: valid_session }

      it "does not change user's location in the database" do
        user.reload
        expect(user.current_location).not_to eq('xxsd')
      end

      it 're-renders edit location template' do
        expect(response).to render_template(:edit_location)
      end
    end
  end
end
