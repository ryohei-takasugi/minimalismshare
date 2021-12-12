require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'email、passwordとpassword_confirmation、nicknameが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上かつ半角英数字混合であれば登録できる' do
        @user.password = 'abc456'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
      # 空でも登録できる
      it 'dream は空でも登録できる' do
        @user.dream = nil
        expect(@user).to be_valid
      end
      it 'high_id は空でも登録できる' do
        @user.high_id = nil
        expect(@user).to be_valid
      end
      it 'low_id は空でも登録できる' do
        @user.low_id = nil
        expect(@user).to be_valid
      end
      it 'housemate_id は空でも登録できる' do
        @user.housemate_id = nil
        expect(@user).to be_valid
      end
      it 'hobby_id は空でも登録できる' do
        @user.hobby_id = nil
        expect(@user).to be_valid
      end
      it 'clean_status_id は空でも登録できる' do
        @user.clean_status_id = nil
        expect(@user).to be_valid
      end
      it 'range_with_store_id は空でも登録できる' do
        @user.range_with_store_id = nil
        expect(@user).to be_valid
      end
      # 0でも登録できる
      it 'dream は0でも登録できる' do
        @user.dream = 0
        expect(@user).to be_valid
      end
      it 'high_id は0でも登録できる' do
        @user.high_id = 0
        expect(@user).to be_valid
      end
      it 'low_id は0でも登録できる' do
        @user.low_id = 0
        expect(@user).to be_valid
      end
      it 'housemate_id は0でも登録できる' do
        @user.housemate_id = 0
        expect(@user).to be_valid
      end
      it 'hobby_id は0でも登録できる' do
        @user.hobby_id = 0
        expect(@user).to be_valid
      end
      it 'clean_status_id は0でも登録できる' do
        @user.clean_status_id = 0
        expect(@user).to be_valid
      end
      it 'range_with_store_id は0でも登録できる' do
        @user.range_with_store_id = 0
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      # 空では登録できない
      it 'emailが空では登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = nil
        @user.password_confirmation = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'nicknameが空では登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      # 文字数制限外では登録できない
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = 'abc45'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'nicknameは50文字以上であれば登録できない' do
        @user.nickname = "123456789012345678901234567890123456789012345678901"
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname is too long (maximum is 50 characters)")
      end
      it 'dreamは50文字以上であれば登録できない' do
        @user.dream = "123456789012345678901234567890123456789012345678901"
        @user.valid?
        expect(@user.errors.full_messages).to include("Dream is too long (maximum is 50 characters)")
      end
      # フォーマット違いでは登録できない
      it 'passwordが数字のみであれば登録できない' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'passwordが英字のみであれば登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'passwordが全角文字であれば登録できない' do
        @user.password = 'パスワード'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'emailは＠なしでは登録できない' do
        @user.email = 'test.test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      # その他
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'abc456'
        @user.password_confirmation = 'abc4567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したemailが存在する場合登録できない' do
        user_already = FactoryBot.create(:user)
        @user.email = user_already.email
        @user.valid?
        expect(@user.errors.full_messages).to include('Email has already been taken')
      end
    end
  end
end
