require 'rails_helper'
include LikeHelper

RSpec.describe 'いいねの投稿／取り消し', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @experience_tag1 = create_experience_tag(user_model: @user1)
    sleep 1 # ソートの並び順がはっきりするように念の為
    @user2 = FactoryBot.create(:user)
    @experience_tag2 = create_experience_tag(user_model: @user2)
  end
  context 'いいね できるとき' do
    it 'ログインしたユーザーは記事閲覧ページに遷移して いいね することができる' do
      # ログインする
      sign_in(user: @user1)
      # 一覧ページに遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      # 一覧ページにいいねの件数が表示される（0件）
      confirm_index(model: @experience_tag2)
      # 閲覧ページへのリンクをクリックする
      click_link(@experience_tag2.title)
      # 閲覧ページに遷移することを確認する
      expect(current_path).to eq(experience_path(@experience_tag2))
      # 閲覧ページにいいねの件数が表示される（0件）
      confirm_show(model: @experience_tag2)
      confirm_like_button(status: true)
      # いいねボタンをクリックする
      click_change_button(button_number: 0, change_count: 1)
      # 閲覧ページにいいねの件数が追加される（1件）
      confirm_show(model: @experience_tag2, like_count: 1)
      confirm_like_button(status: false)
      # 一覧ページに戻る
      visit experiences_path
      # 一覧ページでもいいねの件数が追加される（1件）
      confirm_index(model: @experience_tag2, like_count: 1)
      # ログアウトする
      click_link('ログアウト')
      # いいね した記事のユーザーでログインする
      sign_in(user: @user2)
      # 通知が増えている（1件）
      confirm_header_notice_like(user: @user1, experience_tag: @experience_tag2, notice_count: 1)
      # マイページに遷移する
      visit user_path(@user2)
      # マイページにも通知が増えている（1件）
      confirm_mypage_notice_like(user: @user1, experience_tag: @experience_tag2)
      # 通知の件数が0件になる
      confirm_header_notice_like(user: @user1, experience_tag: @experience_tag2)
    end
    it 'ログインしたユーザーは記事閲覧ページに遷移して いいね済みを取り消す ことができる' do
      # ログインする
      sign_in(user: @user1)
      # 閲覧ページへのリンクをクリックする
      click_link(@experience_tag2.title)
      # 閲覧ページに遷移することを確認する
      expect(current_path).to eq(experience_path(@experience_tag2))
      # いいねボタンをクリックする
      click_change_button(button_number: 0, change_count: 1)
      # 閲覧ページにいいねの件数が追加される（1件）
      confirm_show(model: @experience_tag2, like_count: 1)
      confirm_like_button(status: false)
      # いいねボタンをクリックする
      click_change_button(button_number: 0)
      # 閲覧ページにいいねの件数が現象する（0件）
      confirm_show(model: @experience_tag2, like_count: 0)
      confirm_like_button(status: true)
      # 一覧ページに戻る
      visit experiences_path
      # 一覧ページでもいいねの件数が追加される（0件）
      confirm_index(model: @experience_tag2)
    end
  end
  context 'いいね できないとき' do
    it 'ログインしていないユーザーは記事閲覧ページに遷移しても いいね ボタンが表示されない' do
      # トップページにいる
      basic_visit root_path
      # 記事1の閲覧ページへ遷移する
      visit experience_path(@experience_tag1)
      # いいねボタンが表示されない
      within('main') do
        within('.like') do
          expect(page).to have_no_button
        end
      end
    end
  end
end

RSpec.describe '真似したの投稿／取り消し', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @experience_tag1 = create_experience_tag(user_model: @user1)
    sleep 1 # ソートの並び順がはっきりするように念の為
    @user2 = FactoryBot.create(:user)
    @experience_tag2 = create_experience_tag(user_model: @user2)
  end
  context '真似した できるとき' do
    it 'ログインしたユーザーは記事閲覧ページに遷移して 真似した することができる' do
      # ログインする
      sign_in(user: @user1)
      # 一覧ページに遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      # 一覧ページに真似したの件数が表示される（0件）
      confirm_index(model: @experience_tag2)
      # 閲覧ページへのリンクをクリックする
      click_link(@experience_tag2.title)
      # 閲覧ページに遷移することを確認する
      expect(current_path).to eq(experience_path(@experience_tag2))
      # 閲覧ページに真似したの件数が表示される（0件）
      confirm_show(model: @experience_tag2)
      confirm_imitate_button(status: true)
      # 真似したボタンをクリックする
      click_change_button(button_number: 1, change_count: 1)
      # 閲覧ページに真似したの件数が追加される（1件）
      confirm_show(model: @experience_tag2, imitate_count: 1)
      confirm_imitate_button(status: false)
      # 一覧ページに戻る
      visit experiences_path
      # 一覧ページでも真似したの件数が追加される（1件）
      confirm_index(model: @experience_tag2, imitate_count: 1)
      # ログアウトする
      click_link('ログアウト')
      # いいね した記事のユーザーでログインする
      sign_in(user: @user2)
      # 通知が増えている（1件）
      confirm_header_notice_imitate(user: @user1, experience_tag: @experience_tag2, notice_count: 1)
      # マイページに遷移する
      visit user_path(@user2)
      # マイページにも通知が増えている（1件）
      confirm_mypage_notice_imitate(user: @user1, experience_tag: @experience_tag2)
      # 通知の件数が0件になる
      confirm_header_notice_imitate(user: @user1, experience_tag: @experience_tag2, notice_count: 0)
    end
    it 'ログインしたユーザーは記事閲覧ページに遷移して 真似した済みを取り消す ことができる' do
      # ログインする
      sign_in(user: @user1)
      # 閲覧ページへのリンクをクリックする
      click_link(@experience_tag2.title)
      # 閲覧ページに遷移することを確認する
      expect(current_path).to eq(experience_path(@experience_tag2))
      # 真似したボタンをクリックする
      click_change_button(button_number: 1, change_count: 1)
      # within('main') do
      #   within('.like') do
      #     expect{
      #       all('button')[1].click
      #     }.to change { ExperienceLike.count }.by(1)
      #   end
      # end
      # 閲覧ページに真似したの件数が追加される（1件）
      confirm_show(model: @experience_tag2, imitate_count: 1)
      confirm_imitate_button(status: false)
      # within('main') do
      #   within('.card') do
      #     expect(page).to have_link(@experience_tag2.title, href: experience_path(@experience_tag2))
      #     expect(all('tr')[5]).to have_content('0 いいね')
      #     expect(all('tr')[6]).to have_content('1 真似した')
      #   end
      #   within('.like') do
      #     expect(find('input[name="experiences_like[imitate]"]', visible: false).value).to eq("false")
      #   end
      # end
      # 真似したボタンをクリックする
      click_change_button(button_number: 1, change_count: 0)
      # within('main') do
      #   within('.like') do
      #     expect{
      #       all('button')[1].click
      #     }.to change { ExperienceLike.count }.by(0)
      #   end
      # end
      # 閲覧ページに真似したの件数が現象する（0件）
      confirm_show(model: @experience_tag2)
      confirm_imitate_button(status: true)
      # within('main') do
      #   within('.card') do
      #     expect(page).to have_link(@experience_tag2.title, href: experience_path(@experience_tag2))
      #     expect(all('tr')[5]).to have_content('0 いいね')
      #     expect(all('tr')[6]).to have_content('0 真似した')
      #   end
      #   within('.like') do
      #     expect(find('input[name="experiences_like[imitate]"]', visible: false).value).to eq("true")
      #   end
      # end
      # 一覧ページに戻る
      visit experiences_path
      # 一覧ページでも真似したの件数が追加される（0件）
      confirm_index(model: @experience_tag2)
      # within('main') do
      #   all('.card')[0] do
      #     expect(page).to have_link(@experience_tag2.title, href: experience_path(@experience_tag2))
      #     expect(all('tr')[5]).to have_content('0 いいね')
      #     expect(all('tr')[6]).to have_content('0 真似した')
      #   end
      # end
    end
  end
  context 'いいね できないとき' do
    it 'ログインしていないユーザーは記事閲覧ページに遷移しても いいね ボタンが表示されない' do
      # トップページにいる
      basic_visit root_path
      # 記事1の閲覧ページへ遷移する
      visit experience_path(@experience_tag1)
      # いいねボタンが表示されない
      within('main') do
        within('.like') do
          expect(page).to have_no_button
        end
      end
    end
  end
end
