require 'rails_helper'

RSpec.describe ExperienceTag, type: :model do
  before do
    @experience_tag = FactoryBot.build(:experience_tag)
    @user = FactoryBot.create(:user)
    @experience_tag.user_id = @user.id
  end
  describe '経験の投稿' do
    context '投稿できる場合' do
      it 'title, tags, category_id, period_id, stress, user_id が存在すれば登録できる' do
        expect(@experience_tag).to be_valid
      end
      it 'tags は無くても登録できる' do
        @experience_tag.tags = nil
        expect(@experience_tag).to be_valid
      end
    end
    context '投稿できない場合' do
      # 空では登録できない
      it 'title が空では登録できない' do
        @experience_tag.title = nil
        @experience_tag.valid?
        expect(@experience_tag.errors.full_messages).to include("Title can't be blank")
      end
      it 'category_id が空では登録できない' do
        @experience_tag.category_id = nil
        @experience_tag.valid?
        expect(@experience_tag.errors.full_messages).to include("Category can't be blank")
      end
      it 'period_id が空では登録できない' do
        @experience_tag.period_id = nil
        @experience_tag.valid?
        expect(@experience_tag.errors.full_messages).to include("Period can't be blank")
      end
      it 'stress が空では登録できない' do
        @experience_tag.stress = nil
        @experience_tag.valid?
        expect(@experience_tag.errors.full_messages).to include("Stress can't be blank")
      end
      it 'user_id が空では登録できない' do
        @experience_tag.user_id = nil
        @experience_tag.valid?
        expect(@experience_tag.errors.full_messages).to include("User can't be blank")
      end
      # フォーマットエラー
      it 'category_id が0では登録できない' do
        @experience_tag.category_id = 0
        @experience_tag.valid?
        expect(@experience_tag.errors.full_messages).to include("Category を入力してください")
      end
      it 'period_id が0では登録できない' do
        @experience_tag.period_id = 0
        @experience_tag.valid?
        expect(@experience_tag.errors.full_messages).to include("Period を入力してください")
      end
    end
  end
end
