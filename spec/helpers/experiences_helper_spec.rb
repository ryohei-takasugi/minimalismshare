require 'rails_helper'
include ExperienceTagHelper

RSpec.describe 'いいね有無', type: :helper do
  before do
    @experience = FactoryBot.build(:experience)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in @experience.user
  end
  describe 'ログインユーザーが対象の記事を いいね しているか' do
    context 'レコードがある場合' do
      it 'likeが true の場合' do
        @experience.experience_likes.each do |likes|
          likes.like = true if likes.user_id == @experience.user_id
        end
        expect(helper.user_liked?(@experience)).to eq(true)
      end
      it 'likeが false の場合' do
        @experience.experience_likes.each do |likes|
          likes.like = false if likes.user_id == @experience.user_id
        end
        expect(helper.user_liked?(@experience)).to eq(false)
      end
    end
    context 'レコードがない場合' do
      it 'experience_likes が 空 の場合' do
        @experience.experience_likes = []
        expect(helper.user_liked?(@experience)).to eq(nil)
      end
      it 'experience_likes の対象記事がない場合' do
        @experience.experience_likes = @experience.experience_likes.select do |likes|
          likes.user_id != @experience.user_id
        end
        expect(helper.user_liked?(@experience)).to eq(nil)
      end
    end
  end
  describe 'ログインユーザーが対象の記事を 真似した しているか' do
    context 'レコードがある場合' do
      it 'imitate が true の場合' do
        @experience.experience_likes.each do |likes|
          likes.imitate = true if likes.user_id == @experience.user_id
        end
        expect(helper.user_imitated?(@experience)).to eq(true)
      end
      it 'imitate が false の場合' do
        @experience.experience_likes.each do |likes|
          likes.imitate = false if likes.user_id == @experience.user_id
        end
        expect(helper.user_imitated?(@experience)).to eq(false)
      end
    end
    context 'レコードがない場合' do
      it 'experience_likes が 空 の場合' do
        @experience.experience_likes = []
        expect(helper.user_imitated?(@experience)).to eq(nil)
      end
      it 'experience_likes の対象記事がない場合' do
        @experience.experience_likes = @experience.experience_likes.select do |likes|
          likes.user_id != @experience.user_id
        end
        expect(helper.user_imitated?(@experience)).to eq(nil)
      end
    end
  end
end

RSpec.describe 'いいね数', type: :helper do
  before do
    @experience = FactoryBot.build(:experience)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in @experience.user
    @likes_count    = ExperienceLike.count_likes
    @imitates_count = ExperienceLike.count_imitates
  end
  describe 'いいね' do
    context 'レコードがある場合' do
      it 'いいね数 が 1以上の値を取得できる 場合' do
        expect(helper.count_liked(@likes_count, @experience)).to be_between(1, 25)
      end
    end
    context 'レコードがない場合' do
      it 'いいね数 のリストに対象の記事がない場合' do
        @likes_count[@experience.id] = nil
        expect(helper.count_liked(@likes_count, @experience)).to eq(0)
      end
      it 'いいね数 のリストが空の場合' do
        @likes_count = nil
        expect(helper.count_liked(@likes_count, @experience)).to eq(0)
      end
    end
  end
end

RSpec.describe 'タグ', type: :helper do
  before do
    @tags = Faker::Lorem.words(number: 4)
    @user = FactoryBot.create(:user)
    @experience_tag = create_experience_tag(user_model: @user)
  end
  describe 'タグジョイン' do
    context '引数の値がある場合' do
      it '引数の値が 配列 の場合' do
        expect(helper.join_tags(@tags)).to eq(@tags.join('、'))
      end
      it '引数の値が 文字列 の場合' do
        tag = @tags.join('、')
        expect(helper.join_tags(tag)).to eq(tag)
      end
      it '引数の値が インタンス変数 の場合' do
        expect(helper.join_tags(@experience_tag.tags)).to eq(@experience_tag.tags.map { |tag| tag.name }.join('、'))
      end
    end
    context '引数の値がない場合' do
      it '引数の値がnilの場合' do
        expect(helper.join_tags(nil)).to eq(nil)
      end
    end
  end
end

RSpec.describe '作者判定', type: :helper do
  before do
    @user1 = FactoryBot.create(:user)
    @experience_tag1 = create_experience_tag(user_model: @user1)
    @user2 = FactoryBot.create(:user)
    @experience_tag2 = create_experience_tag(user_model: @user2)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in @user1
  end
  describe '記事の作者か' do
    context '作者の場合' do
      it '作者の場合' do
        expect(helper.confirm_author?(@experience_tag1)).to eq(true)
      end
    end
    context '作者ではない場合' do
      it '作者ではない場合' do
        expect(helper.confirm_author?(@experience_tag2)).to eq(false)
      end
    end
  end
end
