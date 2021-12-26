require 'rails_helper'
include ExperienceTagHelper

RSpec.describe 'ExperienceLikes', type: :request do
  describe 'POST/PATCH/PUT' do
    before do
      @user1 = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user)
      @experience_tag = create_experience_tag(user_model: @user2)
    end
    context 'POST   /experiences/:experience_id/experience_likes' do
      it 'returns http error 401' do
        like_params = { experiences_like: { like: true }, experience_id: @experience_tag.id, user_id: @user1.id }
        expect do
          post "/experiences/#{@experience_tag.id}/experience_likes", params: like_params, headers: nil
        end.to change { ExperienceLike.count }.by(0)
        expect(response).to have_http_status 401
      end
      it 'redirect experiences' do
        sign_in @user2
        like_params = { experiences_like: { like: true }, experience_id: @experience_tag.id, user_id: @user2.id }
        expect do
          post "/experiences/#{@experience_tag.id}/experience_likes", params: like_params, headers: auth_login
        end.to change { ExperienceLike.count }.by(0)
        expect(response).to have_http_status 302
        expect(response.redirect_url.match("http://#{response.request.env['SERVER_NAME']}/(.*)")[1]).to eq('experiences')
      end
      it 'returns http success(like)' do
        sign_in @user1
        like_params = { experiences_like: { like: true }, experience_id: @experience_tag.id, user_id: @user1.id }
        expect do
          post "/experiences/#{@experience_tag.id}/experience_likes", params: like_params, headers: auth_login
        end.to change { ExperienceLike.count }.by(1)
        expect(response).to have_http_status 302
        expect(response.redirect_url.match("http://#{response.request.env['SERVER_NAME']}/(.*)")[1]).to eq("experiences/#{@experience_tag.id}")
      end
      it 'returns http success(imitate)' do
        sign_in @user1
        like_params = { experiences_like: { imitate: true }, experience_id: @experience_tag.id, user_id: @user1.id }
        expect do
          post "/experiences/#{@experience_tag.id}/experience_likes", params: like_params, headers: auth_login
        end.to change { ExperienceLike.count }.by(1)
        expect(response).to have_http_status 302
        expect(response.redirect_url.match("http://#{response.request.env['SERVER_NAME']}/(.*)")[1]).to eq("experiences/#{@experience_tag.id}")
      end
    end
    context 'PATCH  /experiences/:experience_id/experience_likes/:id' do
      before do
        sign_in @user1
        like_params = { experiences_like: { like: true, imitate: true }, experience_id: @experience_tag.id, user_id: @user1.id }
        post "/experiences/#{@experience_tag.id}/experience_likes", params: like_params, headers: auth_login
        @experience_likes = ExperienceLike.find_by(experience_id: @experience_tag.id, user_id: @user1.id)
      end
      it 'returns http error 401' do
        like_params = { experiences_like: { like: true }, experience_id: @experience_tag.id, user_id: @user1.id }
        sign_out @user1
        expect do
          patch "/experiences/#{@experience_tag.id}/experience_likes/#{@experience_likes.id}", params: like_params, headers: nil
        end.to change { ExperienceLike.count }.by(0)
        expect(response).to have_http_status 401
      end
      it 'redirect experiences' do
        sign_out @user1
        sign_in @user2
        like_params = { experiences_like: { like: true }, experience_id: @experience_tag.id, user_id: @user2.id }
        expect do
          patch "/experiences/#{@experience_tag.id}/experience_likes/#{@experience_likes.id}", params: like_params,
                                                                                               headers: auth_login
        end.to change { ExperienceLike.count }.by(0)
        expect(response).to have_http_status 302
        expect(response.redirect_url.match("http://#{response.request.env['SERVER_NAME']}/(.*)")[1]).to eq('experiences')
      end
      it 'returns http success(like)' do
        like_params = { experiences_like: { like: false }, experience_id: @experience_tag.id, user_id: @user1.id }
        expect do
          patch "/experiences/#{@experience_tag.id}/experience_likes/#{@experience_likes.id}", params: like_params,
                                                                                               headers: auth_login
        end.to change { ExperienceLike.count }.by(0)
        expect(response).to have_http_status 302
        expect(response.redirect_url.match("http://#{response.request.env['SERVER_NAME']}/(.*)")[1]).to eq("experiences/#{@experience_tag.id}")
      end
      it 'returns http success(imitate)' do
        like_params = { experiences_like: { imitate: false }, experience_id: @experience_tag.id, user_id: @user1.id }
        expect do
          patch "/experiences/#{@experience_tag.id}/experience_likes/#{@experience_likes.id}", params: like_params,
                                                                                               headers: auth_login
        end.to change { ExperienceLike.count }.by(0)
        expect(response).to have_http_status 302
        expect(response.redirect_url.match("http://#{response.request.env['SERVER_NAME']}/(.*)")[1]).to eq("experiences/#{@experience_tag.id}")
      end
    end
    context 'PUT    /experiences/:experience_id/experience_likes/:id' do
      before do
        sign_in @user1
        like_params = { experiences_like: { like: true, imitate: true }, experience_id: @experience_tag.id, user_id: @user1.id }
        post "/experiences/#{@experience_tag.id}/experience_likes", params: like_params, headers: auth_login
        @experience_likes = ExperienceLike.find_by(experience_id: @experience_tag.id, user_id: @user1.id)
      end
      it 'returns http error 401' do
        like_params = { experiences_like: { like: true }, experience_id: @experience_tag.id, user_id: @user1.id }
        sign_out @user1
        expect do
          put "/experiences/#{@experience_tag.id}/experience_likes/#{@experience_likes.id}", params: like_params, headers: nil
        end.to change { ExperienceLike.count }.by(0)
        expect(response).to have_http_status 401
      end
      it 'redirect experiences' do
        sign_out @user1
        sign_in @user2
        like_params = { experiences_like: { like: true }, experience_id: @experience_tag.id, user_id: @user2.id }
        expect do
          put "/experiences/#{@experience_tag.id}/experience_likes/#{@experience_likes.id}", params: like_params,
                                                                                             headers: auth_login
        end.to change { ExperienceLike.count }.by(0)
        expect(response).to have_http_status 302
        expect(response.redirect_url.match("http://#{response.request.env['SERVER_NAME']}/(.*)")[1]).to eq('experiences')
      end
      it 'returns http success(like)' do
        like_params = { experiences_like: { like: false }, experience_id: @experience_tag.id, user_id: @user1.id }
        expect do
          put "/experiences/#{@experience_tag.id}/experience_likes/#{@experience_likes.id}", params: like_params,
                                                                                             headers: auth_login
        end.to change { ExperienceLike.count }.by(0)
        expect(response).to have_http_status 302
        expect(response.redirect_url.match("http://#{response.request.env['SERVER_NAME']}/(.*)")[1]).to eq("experiences/#{@experience_tag.id}")
      end
      it 'returns http success(imitate)' do
        like_params = { experiences_like: { imitate: false }, experience_id: @experience_tag.id, user_id: @user1.id }
        expect do
          put "/experiences/#{@experience_tag.id}/experience_likes/#{@experience_likes.id}", params: like_params,
                                                                                             headers: auth_login
        end.to change { ExperienceLike.count }.by(0)
        expect(response).to have_http_status 302
        expect(response.redirect_url.match("http://#{response.request.env['SERVER_NAME']}/(.*)")[1]).to eq("experiences/#{@experience_tag.id}")
      end
    end
  end
end
