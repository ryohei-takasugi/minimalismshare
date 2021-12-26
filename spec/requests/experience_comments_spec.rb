require 'rails_helper'
include ExperienceTagHelper

RSpec.describe 'ExperienceComments', type: :request do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    sign_in @user1
    @experience_tag = create_experience_tag(user_model: @user1)
    @post_comment_params = {
      experience_comment: {
        comment: Faker::Lorem.characters(number: rand(1..100))
      },
      user_id: @user2.id,
      experience_id: @experience_tag.id
    }
  end
  describe 'GET' do
    before do
      @after_comment_params = {
        user_id: @user2.id,
        experience_id: @experience_tag.id
      }
      post "/experiences/#{@experience_tag.id}/experience_comments", params: @post_comment_params, headers: auth_login
      @comment = ExperienceComment.find_by(comment: @post_comment_params[:experience_comment][:comment])
    end
    context 'GET    /experiences/:experience_id/experience_comments/:id/edit' do
      it 'returns http error 401' do
        get "/experiences/#{@experience_tag.id}/experience_comments/#{@comment.id}/edit", params: @after_comment_params,
                                                                                          headers: nil
        expect(response).to have_http_status 401
      end
      it 'returns http success' do
        get "/experiences/#{@experience_tag.id}/experience_comments/#{@comment.id}/edit", params: @after_comment_params,
                                                                                          headers: auth_login
        expect(response).to have_http_status 200
        expect(response.body).to include(@comment.comment)
        expect(response.redirect_url).to eq(nil)
      end
    end
  end
  describe 'POST' do
    context 'POST   /experiences/:experience_id/experience_comments' do
      it 'returns http error 401' do
        expect do
          post "/experiences/#{@experience_tag.id}/experience_comments", params: @post_comment_params, headers: nil
        end.to change { ExperienceComment.count }.by(0)
        expect(response).to have_http_status 401
      end
      it 'error(render show)' do
        @post_comment_params[:experience_comment][:comment] = ''
        expect do
          post "/experiences/#{@experience_tag.id}/experience_comments", params: @post_comment_params, headers: auth_login
        end.to change { ExperienceComment.count }.by(0)
        expect(response).to have_http_status 200
        expect(response.redirect_url).to eq(nil)
      end
      it 'success(redirect show)' do
        expect do
          post "/experiences/#{@experience_tag.id}/experience_comments", params: @post_comment_params, headers: auth_login
        end.to change { ExperienceComment.count }.by(1)
        expect(response).to have_http_status 302
        expect(response.redirect_url.match("http://#{response.request.env['SERVER_NAME']}/(.*)")[1]).to eq("experiences/#{@experience_tag.id}")
      end
    end
  end
  describe 'PATCH/PUT/DELETE' do
    before do
      @after_comment_params = {
        experience_comment: {
          comment: Faker::Lorem.characters(number: rand(1..100))
        },
        user_id: @user2.id,
        experience_id: @experience_tag.id
      }
      post "/experiences/#{@experience_tag.id}/experience_comments", params: @post_comment_params, headers: auth_login
      @comment = ExperienceComment.find_by(comment: @post_comment_params[:experience_comment][:comment])
    end
    context 'PATCH  /experiences/:experience_id/experience_comments/:id' do
      it 'returns http error 401' do
        expect do
          patch "/experiences/#{@experience_tag.id}/experience_comments/#{@comment.id}", params: @after_comment_params,
                                                                                         headers: nil
        end.to change { ExperienceComment.count }.by(0)
        expect(response).to have_http_status 401
      end
      it 'error(render show)' do
        @after_comment_params[:experience_comment][:comment] = ''
        expect do
          patch "/experiences/#{@experience_tag.id}/experience_comments/#{@comment.id}", params: @after_comment_params,
                                                                                         headers: auth_login
        end.to change { ExperienceComment.count }.by(0)
        expect(response).to have_http_status 200
        expect(response.redirect_url).to eq(nil)
      end
      it 'success(redirect show)' do
        expect do
          patch "/experiences/#{@experience_tag.id}/experience_comments/#{@comment.id}", params: @after_comment_params,
                                                                                         headers: auth_login
        end.to change { ExperienceComment.count }.by(0)
        expect(response).to have_http_status 302
        expect(response.redirect_url.match("http://#{response.request.env['SERVER_NAME']}/(.*)")[1]).to eq("experiences/#{@experience_tag.id}")
      end
    end
    context 'PUT    /experiences/:experience_id/experience_comments/:id' do
      it 'returns http error 401' do
        expect do
          put "/experiences/#{@experience_tag.id}/experience_comments/#{@comment.id}", params: @after_comment_params, headers: nil
        end.to change { ExperienceComment.count }.by(0)
        expect(response).to have_http_status 401
      end
      it 'error(render show)' do
        @after_comment_params[:experience_comment][:comment] = ''
        expect do
          put "/experiences/#{@experience_tag.id}/experience_comments/#{@comment.id}", params: @after_comment_params,
                                                                                       headers: auth_login
        end.to change { ExperienceComment.count }.by(0)
        expect(response).to have_http_status 200
        expect(response.redirect_url).to eq(nil)
      end
      it 'returns http success' do
        expect do
          put "/experiences/#{@experience_tag.id}/experience_comments/#{@comment.id}", params: @after_comment_params,
                                                                                       headers: auth_login
        end.to change { ExperienceComment.count }.by(0)
        expect(response).to have_http_status 302
        expect(response.redirect_url.match("http://#{response.request.env['SERVER_NAME']}/(.*)")[1]).to eq("experiences/#{@experience_tag.id}")
      end
    end
    context 'DELETE /experiences/:experience_id/experience_comments/:id' do
      it 'returns http error 401' do
        expect do
          delete "/experiences/#{@experience_tag.id}/experience_comments/#{@comment.id}", params: nil, headers: nil
        end.to change { ExperienceComment.count }.by(0)
        expect(response).to have_http_status 401
      end
      it 'returns http success' do
        expect do
          delete "/experiences/#{@experience_tag.id}/experience_comments/#{@comment.id}", params: nil, headers: auth_login
        end.to change { ExperienceComment.count }.by(-1)
        expect(response).to have_http_status 302
        expect(response.redirect_url.match("http://#{response.request.env['SERVER_NAME']}/(.*)")[1]).to eq("experiences/#{@experience_tag.id}")
      end
    end
  end
end
