require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /show' do
    before do
      @user1 = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user)
    end
    it 'returns http error 401' do
      sign_in @user1
      get "/users/#{@user1.id}", params: nil, headers: nil
      expect(response).to have_http_status 401
    end
    it 'redirect_to experiences' do
      sign_in @user2
      get "/users/#{@user1.id}", params: nil, headers: auth_login
      expect(response).to have_http_status 302
    end
    it 'returns http success' do
      sign_in @user1
      get "/users/#{@user1.id}", params: nil, headers: auth_login
      expect(response).to have_http_status 200
    end
  end
end
