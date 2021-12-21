require 'rails_helper'
include ExperienceTagHelper

RSpec.describe 'Experiences', type: :request do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end
  describe 'GET' do
    context 'GET    /experiences' do
      it 'returns http error 401' do
        get '/experiences', params: nil, headers: nil
        expect(response).to have_http_status 401
      end
      it 'returns http success' do
        get '/experiences', params: nil, headers: auth_login
        expect(response).to have_http_status 200
      end
    end
    context 'GET    /experiences/new' do
      before do
        sign_in @user1
      end
      it 'returns http error 401' do
        get '/experiences/new', params: nil, headers: nil
        expect(response).to have_http_status 401
      end
      it 'returns http success' do
        get '/experiences/new', params: nil, headers: auth_login
        expect(response).to have_http_status 200
      end
    end
    context 'GET    /experiences/:id/edit' do
      before do
        @experience_tag = create_experience_tag(user_model: @user1)
      end
      it 'returns http error 401' do
        get "/experiences/#{@experience_tag.id}/edit", params: { id: @experience_tag.id }, headers: nil
        expect(response).to have_http_status 401
      end
      it 'redirect_to experiences' do
        sign_in @user2
        get "/experiences/#{@experience_tag.id}/edit", params: { id: @experience_tag.id }, headers: auth_login
        expect(response).to have_http_status 302
        expect(response.redirect_url.match("http://#{response.request.env["SERVER_NAME"]}/(.*)")[1]).to eq("experiences")
      end
      it 'returns http success' do
        sign_in @user1
        get "/experiences/#{@experience_tag.id}/edit", params: { id: @experience_tag.id }, headers: auth_login
        expect(response).to have_http_status 200
      end
    end
    context 'GET    /experiences/:id' do
      before do
        @experience_tag = create_experience_tag(user_model: @user1)
      end
      it 'returns http error 401' do
        get "/experiences/#{@experience_tag.id}", params: { id: @experience_tag.id }, headers: nil
        expect(response).to have_http_status 401
      end
      it 'returns http success' do
        sign_in @user2
        get "/experiences/#{@experience_tag.id}", params: nil, headers: auth_login
        expect(response).to have_http_status 200
      end
      it 'returns http success' do
        sign_in @user1
        get "/experiences/#{@experience_tag.id}", params: nil, headers: auth_login
        expect(response).to have_http_status 200
      end
    end
    context 'GET    /experiences/search_tag' do
      before do
        sign_in @user1
        @tag1 = FactoryBot.create(:tag)
        @tag2 = FactoryBot.build(:tag)
      end
      it 'returns http error 401' do
        @keyword_params = { keyword: @tag1.name }
        get '/experiences/search_tag', params: @keyword_params, headers: nil
        expect(response).to have_http_status 401
      end
      it 'returns http success(Not Found)' do
        @keyword_params = { keyword: @tag2.name }
        get '/experiences/search_tag', params: @keyword_params, headers: auth_login
        expect(response).to have_http_status 200
        expect(response.content_type).to eq "application/json; charset=utf-8"
        expect(JSON.parse(response.body)["keyword"].size).to eq(0)
      end
      it 'returns http success' do
        @keyword_params = { keyword: @tag1.name }
        get '/experiences/search_tag', params: @keyword_params, headers: auth_login
        expect(response).to have_http_status 200
        expect(response.content_type).to eq "application/json; charset=utf-8"
        expect(JSON.parse(response.body)["keyword"].size).to eq(1)
        JSON.parse(response.body)["keyword"].each do |word|
          expect(word["name"]).to eq(@tag1.name)
        end
      end
    end
    context 'GET    /experiences/search_index' do
      before do
        @q_params = {"q"=>{"title_or_stress_or_content_body_cont"=>"", "tags_id_eq"=>"", "category_id_eq"=>"1", "period_id_eq"=>"", "user_high_id_eq"=>"", "user_low_id_eq"=>"", "user_housemate_id_eq"=>"", "user_hobby_id_eq"=>"", "user_clean_status_id_eq"=>"", "user_range_with_store_id_eq"=>"", "sorts"=>"created_at desc"}, "button"=>""}
      end
      it 'returns http error 401' do
        get '/experiences/search_index', params: @q_params, headers: nil
        expect(response).to have_http_status 401
      end
      it 'returns http success' do
        get '/experiences/search_index', params: @q_params, headers: auth_login
        expect(response).to have_http_status 200
      end
    end
  end
  describe 'POST/PATCH/PUT' do
    before do
      sign_in @user1
    end
    context 'POST   /experiences' do
      before do
        @experience_tag = FactoryBot.build(:experience_tag)
        @build_params = {
          experience_tag: {
            title: @experience_tag.title,
            tags: @experience_tag.tags,
            stress: @experience_tag.stress,
            category_id: @experience_tag.category_id,
            period_id: @experience_tag.period_id,
            content: "test"
          },
          user_id: @user1.id
        }
      end
      it 'returns http error 401' do
        expect do
          post "/experiences", params: @build_params, headers: nil
        end.to change { Experience.count }.by(0)
      end
      it 'render experiences/new' do
        @build_params[:experience_tag][:title] = nil
        expect do
          post "/experiences", params: @build_params, headers: auth_login
        end.to change { Experience.count }.by(0)
        expect(response.body).to include("記事の新規作成")
        expect(response.redirect_url).to eq(nil)
      end
      it 'returns http success' do
        expect do
          post "/experiences", params: @build_params, headers: auth_login
        end.to change { Experience.count }.by(1)
        expect(response.redirect_url.match("http://#{response.request.env["SERVER_NAME"]}/(.*)")[1]).to eq("experiences")
      end
    end
    context 'PATCH  /experiences/:id' do
      before do
        @experience_tag1 = create_experience_tag(user_model: @user1)
        @experience_tag2 = FactoryBot.build(:experience_tag)
        @update_params = {
          experience_tag: {
            title: @experience_tag2.title,
            tags: @experience_tag2.tags,
            stress: @experience_tag2.stress,
            category_id: @experience_tag2.category_id,
            period_id: @experience_tag2.period_id,
            content: "test"
          },
          user_id: @user1.id
        }
      end
      it 'returns http error 401' do
        expect do
          patch "/experiences/#{@experience_tag1.id}", params: @update_params, headers: nil
        end.to change { Experience.count }.by(0)
      end
      it 'render experiences/:id/edit' do
        @update_params[:experience_tag][:title] = nil
        expect do
          patch "/experiences/#{@experience_tag1.id}", params: @update_params, headers: auth_login
        end.to change { Experience.count }.by(0)
        after_data = Experience.find(@experience_tag1.id)
        expect(after_data.title).to eq(@experience_tag1.title)
        expect(response.body).to include("記事の編集")
        expect(response.redirect_url).to eq(nil)
      end
      it 'returns http success' do
        expect do
          patch "/experiences/#{@experience_tag1.id}", params: @update_params, headers: auth_login
        end.to change { Experience.count }.by(0)
        expect(response).to have_http_status 302
        after_data = Experience.find(@experience_tag1.id)
        expect(after_data.title).to eq(@experience_tag2.title)
        expect(response.redirect_url.match("http://#{response.request.env["SERVER_NAME"]}/(.*)")[1]).to eq("experiences/#{@experience_tag1.id}")
      end
    end
    context 'PUT    /experiences/:id' do
      before do
        @experience_tag1 = create_experience_tag(user_model: @user1)
        @experience_tag2 = FactoryBot.build(:experience_tag)
        @update_params = {
          experience_tag: {
            title: @experience_tag2.title,
            tags: @experience_tag2.tags,
            stress: @experience_tag2.stress,
            category_id: @experience_tag2.category_id,
            period_id: @experience_tag2.period_id,
            content: "test"
          },
          user_id: @user1.id
        }
      end
      it 'returns http error 401' do
        expect do
          patch "/experiences/#{@experience_tag1.id}", params: @update_params, headers: nil
        end.to change { Experience.count }.by(0)
      end
      it 'render experiences/:id/edit' do
        @update_params[:experience_tag][:title] = nil
        expect do
          patch "/experiences/#{@experience_tag1.id}", params: @update_params, headers: auth_login
        end.to change { Experience.count }.by(0)
        after_data = Experience.find(@experience_tag1.id)
        expect(after_data.title).to eq(@experience_tag1.title)
        expect(response.body).to include("記事の編集")
        expect(response.redirect_url).to eq(nil)
      end
      it 'returns http success' do
        expect do
          put "/experiences/#{@experience_tag1.id}", params: @update_params, headers: auth_login
        end.to change { Experience.count }.by(0)
        expect(response).to have_http_status 302
        after_data = Experience.find(@experience_tag1.id)
        expect(after_data.title).to eq(@experience_tag2.title)
        expect(response.redirect_url.match("http://#{response.request.env["SERVER_NAME"]}/(.*)")[1]).to eq("experiences/#{@experience_tag1.id}")
      end
    end
    context 'DELETE /experiences/:id' do
      before do
        @experience_tag1 = create_experience_tag(user_model: @user1)
      end
      it 'returns http success' do
        expect do
          delete "/experiences/#{@experience_tag1.id}", params: nil, headers: auth_login
        end.to change { Experience.count }.by(-1)
        expect(response).to have_http_status 302
        expect(response.redirect_url.match("http://#{response.request.env["SERVER_NAME"]}/(.*)")[1]).to eq("experiences")
      end
    end
  end
end
