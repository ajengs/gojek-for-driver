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
    context 'with valid session' do
      before { get :index, params: {}, session: valid_session}

      it "returns a success response" do
        expect(response).to be_success
      end

      it 'populates an @user with current user' do
        expect(assigns(:user)).to eq(user)
      end

      it 'renders the :index template' do
        expect(response).to render_template(:index)
      end
    end

    it 'redirects to login page if session is invalid' do
      get :index
      expect(response).to redirect_to(login_path)
    end
  end

  describe "GET #new" do
    before { get :new }

    it "returns a success response without session" do
      expect(response).to be_success
    end

    it 'assigns a new User to @user' do
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders the :new template' do
      expect(response).to render_template(:new)
    end

    it 'redirects to dashboard page if session is valid' do
      get :new, params: {}, session: valid_session
      expect(response).to redirect_to(index_path)
    end
  end

  describe "GET #edit" do
    context 'with valid session' do
      before { get :edit, params: {id: user.to_param}, session: valid_session }

      it "returns a success response" do
        expect(response).to be_success
      end

      it 'populates an @user with current user' do
        expect(assigns(:user)).to eq(user)
      end

      it 'renders the :edit template' do
        expect(response).to render_template(:edit)
      end
    end

    it 'redirects to login page if session is invalid' do
      get :edit, params: {id: user.to_param}
      expect(response).to redirect_to(login_path)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: {user: valid_attributes}
        }.to change(User, :count).by(1)
      end

      it "redirects to the login path" do
        post :create, params: {user: valid_attributes}
        expect(response).to redirect_to(login_path)
      end
    end

    context "with invalid params" do
      it 'does not save the new user in the database' do
        expect{
          post :create, params: {user: invalid_attributes}
        }.not_to change(User, :count)
      end

      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {user: invalid_attributes}
        expect(response).to be_success
      end

      it 're-renders the :new template' do
        post :create, params: {user: invalid_attributes}
        expect(response).to render_template(:new)
      end
    end

    it 'redirects to dashboard page if session is valid' do
      post :create, params: {user: valid_attributes}, session: valid_session
      expect(response).to redirect_to(index_path)
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
        put :update, params: {id: user.to_param, user: new_attributes}, session: valid_session
        expect(response).to redirect_to(user_path)
      end
    end

    context "with invalid params" do
      before { put :update, params: {id: user.to_param, user: invalid_attributes}, session: valid_session }

      it "returns a success response (i.e. to display the 'edit' template)" do
        expect(response).to be_success
      end

      it 'renders the :edit template' do
        expect(response).to render_template(:edit)
      end
    end

    it 'redirects to login page if session is invalid' do
      put :update, params: {id: user.to_param, user: valid_attributes}
      expect(response).to redirect_to(login_path)
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
