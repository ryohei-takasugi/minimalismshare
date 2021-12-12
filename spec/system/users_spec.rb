require 'rails_helper'

RSpec.describe 'ユーザーの新規作成', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do
    it '必須情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      basic_visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_link('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'ニックネーム', with: @user.nickname
      fill_in 'Eメール', with: @user.email
      fill_in 'パスワード', with: @user.password
      fill_in '確認用', with: @user.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      # 一覧ページへ遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      # 「アカウント登録が完了しました」の文字があることを確認する
      expect(page).to have_content('アカウント登録が完了しました')
      # トップページにログアウトボタンが表示されることを確認する
      expect(
        find('.user-info').find('span').hover
      ).to have_content('ログアウト')
      # トップページにニックネームが表示されることを確認する
      expect(
        find('.user-info').find('span').hover
      ).to have_content(@user.nickname)
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_link('新規登録')
      expect(page).to have_no_link('ログイン')
    end
    it '全ての情報を入力すればユーザー新規登録ができて一覧ページに移動する' do
      # トップページに移動する
      basic_visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_link('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'ニックネーム', with: @user.nickname
      fill_in 'Eメール', with: @user.email
      fill_in 'パスワード', with: @user.password
      fill_in '確認用', with: @user.password_confirmation
      fill_in '夢・目標', with: @user.dream
      select @user.high.name, from: 'user_high_id'
      select @user.low.name, from: 'user_low_id'
      select @user.housemate.name, from: 'user_housemate_id'
      select @user.hobby.name, from: 'user_hobby_id'
      select @user.range_with_store.name, from: 'user_range_with_store_id'
      select @user.clean_status.name, from: 'user_clean_status_id'
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      # 一覧ページへ遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      # 「アカウント登録が完了しました」の文字があることを確認する
      expect(page).to have_content('アカウント登録が完了しました')
      # トップページにログアウトボタンが表示されることを確認する
      expect(
        find('.user-info').find('span').hover
      ).to have_content('ログアウト')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_link('新規登録')
      expect(page).to have_no_link('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      basic_visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_link('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'ニックネーム', with: nil
      fill_in 'Eメール', with: nil
      fill_in 'パスワード', with: nil
      fill_in '確認用', with: nil
      fill_in '夢・目標', with: nil
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq(user_registration_path)
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      basic_visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_link('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'Eメール', with: @user.email
      fill_in 'パスワード', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # 一覧ページへ遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      # 「ログインしました」の文字があることを確認する
      expect(page).to have_content('ログインしました')
      # カーソルを合わせるとログアウトボタンが表示されることを確認する
      expect(
        find('.user-info').find('span').hover
      ).to have_content('ログアウト')
      # トップページにニックネームが表示されることを確認する
      expect(
        find('.user-info').find('span').hover
      ).to have_content(@user.nickname)
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_link('新規登録')
      expect(page).to have_no_link('ログイン')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      basic_visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_link('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'Eメール', with: nil
      fill_in 'パスワード', with: nil
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
