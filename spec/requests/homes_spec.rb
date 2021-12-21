require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'GET    /' do
    it 'returns http error' do
      get root_path, params: nil, headers: nil
      expect(response).to have_http_status(401)
    end
    it 'returns http success' do
      get root_path, params: nil, headers: auth_login
      expect(response).to have_http_status(:success)
    end
  end
end
