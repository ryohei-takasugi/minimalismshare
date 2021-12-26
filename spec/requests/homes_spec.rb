require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'GET' do
    context 'GET    /' do
      it 'returns http error' do
        get '/', params: nil, headers: nil
        expect(response).to have_http_status 401
      end
      it 'returns http success' do
        get '/', params: nil, headers: auth_login
        expect(response).to have_http_status 200
      end
    end
    context 'GET    /homes' do
      it 'returns http error' do
        get '/homes', params: nil, headers: nil
        expect(response).to have_http_status 401
      end
      it 'returns http success' do
        get '/homes', params: nil, headers: auth_login
        expect(response).to have_http_status 200
      end
    end
    context 'GET    /homes/about' do
      it 'returns http error' do
        get '/homes/about', params: nil, headers: nil
        expect(response).to have_http_status 401
      end
      it 'returns http success' do
        get '/homes/about', params: nil, headers: auth_login
        expect(response).to have_http_status 200
      end
    end
  end
end
