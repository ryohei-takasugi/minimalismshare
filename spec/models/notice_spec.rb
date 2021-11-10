require 'rails_helper'

RSpec.describe Notice, type: :model do
  before do
    @notice = FactoryBot.build(:notice)
  end
  describe '通知の登録' do
    context '登録できる場合' do
      it 'message, url, user_id が存在すれば登録できる' do
        expect(@notice).to be_valid
      end
      it 'read は無くても登録できる' do
        expect(@notice).to be_valid
      end
    end
    context '登録できない場合' do
      it 'message が空では登録できない' do
        @notice.message = nil
        @notice.valid?
        expect(@notice.errors.full_messages).to include("Message can't be blank")
      end
      it 'url が空では登録できない' do
        @notice.url = nil
        @notice.valid?
        expect(@notice.errors.full_messages).to include("Url can't be blank")
      end
      it 'user_id が空では登録できない' do
        @notice.user = nil
        @notice.valid?
        expect(@notice.errors.full_messages).to include('User must exist')
      end
    end
  end
end
