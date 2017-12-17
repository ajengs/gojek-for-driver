require 'rails_helper'

RSpec.describe SessionController, type: :controller do
  before :each do
    @user = create(:user, phone: '12345678', email: 'user@aaa.com', password: 'longpassword', password_confirmation: 'longpassword')
  end

  describe 'GET #new' do
    it 'renders the :new template' do
      get :new
      expect(:response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid phone or email and password' do
      it 'assigns user_id to session variable with login phone' do
        post :create, params: { login: '12345678', password: 'longpassword' }
        expect(session[:gopartner_user_id]).to eq(@user.id)
      end

      it 'assigns user_id to session variable with login phone' do
        post :create, params: { login: 'user@aaa.com', password: 'longpassword' }
        expect(session[:gopartner_user_id]).to eq(@user.id)
      end

      it 'redirects to index page' do
        post :create, params: { login: '12345678', password: 'longpassword' }
        expect(response).to redirect_to(index_path)
      end
    end

    context 'with invalid phone and password' do
      it 're-renders to login page' do
        post :create, params: { login: '12345678', password: 'wrongpassword' }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'removes user_id from session variable' do
      delete :destroy, params: { id: @user }
      expect(session[:gopartner_user_id]).to eq(nil)
    end

    it 'redirects to login page' do
      delete :destroy, params: { id: @user }
      expect(response).to redirect_to(login_path)
    end
  end
end

