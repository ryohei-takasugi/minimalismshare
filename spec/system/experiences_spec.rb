require 'rails_helper'
include ShowExperienceHelper

RSpec.describe '記事の投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @experience_tag = build_experience_tag(user_model: @user)
  end

  context '投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      sign_in(user: @user)
      # 一覧ページに遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      # 「記事がありません。」と表示すること
      within('main') do
        expect(page).to have_content('記事がありません。')
      end
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_link('記事を書く', href: new_experience_path)
      # 投稿ページに移動する
      visit new_experience_path
      # フォームに情報を入力する
      fill_in 'タイトル', with: @experience_tag.title
      fill_in 'experience_tag[tags]', with: @experience_tag.tags # タグだけは名称ではエラーがでるためnameで対応
      fill_in 'ストレス', with: @experience_tag.stress
      select 'やってみた', from: 'experience_tag_category_id'
      select '半年程度', from: 'experience_tag_period_id'
      fill_in_rich_text_area nil, with: @experience_tag.content
      # 送信するとExperienceモデルのカウントが1上がり、ExperienceTagRelationモデルのカウントが1以上、Tagモデルのカウントが0以上上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Experience.count }.by(1) and change { ExperienceTagRelation.count }.by_at_least(1) and change do
                                                                                                               Tag.count
                                                                                                             end.by_at_least(0)
      # 一覧ページに遷移することを確認する
      expect(current_path).to eq(experiences_path)
      # 「新しい記事を登録しました」の文字があることを確認する
      expect(page).to have_content('新しい記事を登録しました')
      # 一覧には先ほど投稿した内容が存在することを確認する
      expect(page).to have_link(@user.nickname)
      expect(page).to have_link(@experience_tag.title)
      expect(page).to have_content(@experience_tag.stress)
      expect(@experience_tag.tags.split(',').size).to be >= 1
      @experience_tag.tags.split(',').each do |tag|
        expect(page).to have_content(tag)
      end
      expect(page).to have_no_content(@experience_tag.content)
    end
  end
  context '投稿ができないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに移動する
      basic_visit root_path
      # 新規投稿ページへのボタンがないことを確認する
      expect(page).to have_no_link('記事を書く')
    end
  end
end

RSpec.describe '記事の閲覧', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @experience_tag = create_experience_tag(user_model: @user)
  end
  context '閲覧できるとき' do
    it 'ログインしたユーザーは記事閲覧ページに遷移してコメント投稿欄が表示される' do
      # ログインする
      sign_in(user: @user)
      # 記事のタイトル名がリンクであることを確認する
      expect(page).to have_link(@experience_tag.title, href: experience_path(@experience_tag))
      # 閲覧ページへのリンクをクリックする
      click_link(@experience_tag.title)
      # 閲覧ページに遷移することを確認する
      expect(current_path).to eq(experience_path(@experience_tag))
      # 閲覧ページに記事の内容が含まれている
      confirm_show(model: @experience_tag)
      confirm_content(model: @experience_tag)
      # コメント用のフォームが存在する
      expect(page).to have_selector('form')
    end
    it 'ログインしていない状態で記事閲覧ページに遷移できるもののコメント投稿欄が表示されない' do
      # トップページに移動する
      visit experiences_path
      # 記事のタイトル名がリンクであることを確認する
      expect(page).to have_link(@experience_tag.title, href: experience_path(@experience_tag))
      # 閲覧ページへのリンクをクリックする
      click_link(@experience_tag.title)
      # 閲覧ページに遷移することを確認する
      expect(current_path).to eq(experience_path(@experience_tag))
      # 閲覧ページに記事の内容が含まれている
      confirm_show(model: @experience_tag)
      confirm_content(model: @experience_tag)
      # フォームが存在しないことを確認する
      expect(page).to have_no_selector('form')
    end
  end
end

RSpec.describe '記事の編集', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @experience_tag1 = create_experience_tag(user_model: @user1)
    @user2 = FactoryBot.create(:user)
    @experience_tag2 = create_experience_tag(user_model: @user2)
  end
  context '記事編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したものであれば編集ができる' do
      # 記事1を投稿したユーザーでログインする
      sign_in(user: @user1)
      # 記事1の閲覧ページへ遷移する
      visit experience_path(@experience_tag1)
      # 記事1に「編集」へのリンクがあることを確認する
      expect(page).to have_link('編集', href: edit_experience_path(@experience_tag1))
      # 編集ページへ遷移する
      visit edit_experience_path(@experience_tag1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(find('#experience_tag_title').value).to eq(@experience_tag1.title)
      expect(find('#experience_tag_name').value).to eq(@experience_tag1.tags.map { |tag| tag.name }.join(', '))
      expect(find('#experience_tag_stress').value).to eq(@experience_tag1.stress)
      expect(find('#experience_tag_category_id').value).to eq(@experience_tag1.category_id.to_s)
      expect(find('#experience_tag_period_id').value).to eq(@experience_tag1.period_id.to_s)
      expect(find('#experience_tag_content').value).to include(@experience_tag1.content.body.to_plain_text.gsub(/\n/, '').strip)
      # 投稿内容を編集する
      edit_show(model: @experience_tag1)
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Experience.count }.by(0) and change { ExperienceTagRelation.count }.by(1) and change do
                                                                                                      Tag.count
                                                                                                    end.by_at_least(0)
      # 閲覧ページに遷移することを確認する
      expect(current_path).to eq(experience_path(@experience_tag1))
      # 「記事を更新しました」の文字があることを確認する
      expect(page).to have_content('記事を更新しました')
      # 一覧には先ほど投稿した内容が存在することを確認する
      confirm_show(model: @experience_tag1, edit: true)
      confirm_content(model: @experience_tag1)
    end
  end
  context '記事編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したものであれば編集画面には遷移できない' do
      # 記事1を投稿したユーザーでログインする
      sign_in(user: @user1)
      # 記事2の閲覧ページへ遷移する
      visit experience_path(@experience_tag2)
      # 記事2に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link('編集')
    end
    it 'ログインしていないと編集画面には遷移できない' do
      # トップページにいる
      basic_visit root_path
      # 記事1の閲覧ページへ遷移する
      visit experience_path(@experience_tag1)
      # 記事1に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link('編集')
      # 記事2の閲覧ページへ遷移する
      visit experience_path(@experience_tag2)
      # 記事2に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link('編集')
    end
  end
end

RSpec.describe '記事の削除', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @experience_tag1 = create_experience_tag(user_model: @user1)
    @user2 = FactoryBot.create(:user)
    @experience_tag2 = create_experience_tag(user_model: @user2)
  end
  context '記事削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿した記事の削除ができる' do
      # 記事1を投稿したユーザーでログインする
      sign_in(user: @user1)
      # 記事1の閲覧ページへ遷移する
      visit experience_path(@experience_tag1)
      # 記事1に「削除」へのリンクがあることを確認する
      expect(page).to have_link('削除')
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect do
        page.accept_confirm('この操作は取り消すことができません。本当に記事の削除を実行しますか?') do
          click_link('削除')
        end
        sleep 0.5 # データベース削除までに少し時間が必要
      end.to change { Experience.count }.by(-1) and change do
                                                      ExperienceTagRelation.count
                                                    end.by(@experience_tag1.tags.split(',').size) and change do
                                                                                                        Tag.count
                                                                                                      end.by(0)
      # 一覧ページに遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      # 「記事を更新しました」の文字があることを確認する
      expect(page).to have_content('記事を削除しました')
      # 一覧には先ほど投稿した内容が存在しないことを確認する
      confirm_show_no_have(model: @experience_tag1)
    end
  end
  context '記事削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した記事の削除ができない' do
      # 記事1を投稿したユーザーでログインする
      sign_in(user: @user1)
      # 記事2の閲覧ページへ遷移する
      visit experience_path(@experience_tag2)
      # 記事2に「削除」へのリンクがないことを確認する
      expect(page).to have_no_link('削除')
    end
    it 'ログインしていないと記事の削除ボタンがない' do
      # トップページにいる
      basic_visit root_path
      # 記事1の閲覧ページへ遷移する
      visit experience_path(@experience_tag1)
      # 記事1に「削除」へのリンクがないことを確認する
      expect(page).to have_no_link('削除')
      # 記事2の閲覧ページへ遷移する
      visit experience_path(@experience_tag2)
      # 記事2に「削除」へのリンクがないことを確認する
      expect(page).to have_no_link('削除')
    end
  end
end

RSpec.describe '記事の検索', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @experience_tag1 = create_experience_tag(user_model: @user1)
    sleep 1 # ソートの並び順がはっきりするように念の為
    @user2 = FactoryBot.create(:user)
    @experience_tag2 = create_experience_tag(user_model: @user2)
  end
  context '検索に合致するものがあるとき' do
    it 'タイトルの検索が合致する' do
      # 記事1を投稿したユーザーでログインする
      sign_in(user: @user1)
      # 一覧ページに遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      within('main') do
        within('.search-items') do
          # 検索条件 テキスト検索 に記事1の値を入力する
          fill_in 'テキスト検索', with: @experience_tag1.title
          # 検索する
          click_button '検索'
        end
      end
      # 記事1は検索に合致し、表示することを確認する
      confirm_show(model: @experience_tag1)
      # 記事2は検索に合致せず、表示しないことを確認する
      confirm_show_no_have(model: @experience_tag2)
    end
    it 'ストレスの検索が合致する' do
      # 記事1を投稿したユーザーでログインする
      sign_in(user: @user1)
      # 一覧ページに遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      within('main') do
        within('.search-items') do
          # 検索条件 テキスト検索 に記事1の値を入力する
          fill_in 'テキスト検索', with: @experience_tag1.stress
          # 検索する
          click_button '検索'
        end
      end
      # 記事1は検索に合致し、表示することを確認する
      confirm_show(model: @experience_tag1)
      # 記事2は検索に合致せず、表示しないことを確認する
      confirm_show_no_have(model: @experience_tag2)
    end
    it '本文の検索が合致する' do
      # 記事1を投稿したユーザーでログインする
      sign_in(user: @user1)
      # 一覧ページに遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      within('main') do
        within('.search-items') do
          # 検索条件 テキスト検索 に記事1の値を入力する
          fill_in 'テキスト検索', with: @experience_tag1.content.body.to_plain_text.gsub(/\n/, '').strip
          # 検索する
          click_button '検索'
        end
      end
      # 記事1は検索に合致し、表示することを確認する
      confirm_show(model: @experience_tag1)
      # 記事2は検索に合致せず、表示しないことを確認する
      confirm_show_no_have(model: @experience_tag2)
    end
    it 'タグの検索が合致する' do
      # 記事1を投稿したユーザーでログインする
      sign_in(user: @user1)
      # 一覧ページに遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      within('main') do
        within('.search-items') do
          tag1_list  = @experience_tag1.tags.map { |tag| tag.name }
          tag2_list  = @experience_tag2.tags.map { |tag| tag.name }
          target_tag = ''
          (0..tag1_list.size).each do |i|
            unless tag2_list.include?(tag1_list[i])
              target_tag = tag1_list[i]
              break
            end
          end
          find('details').click
          # 検索条件 タグ は以下と等しい に記事1の値を入力する
          select target_tag, from: 'q_tags_id_eq'
          # 検索する
          click_button '検索'
        end
      end
      # 記事1は検索に合致し、表示することを確認する
      confirm_show(model: @experience_tag1)
      # 記事2は検索に合致せず、表示しないことを確認する
      confirm_show_no_have(model: @experience_tag2)
    end
    it 'カテゴリの検索が合致する' do
      # 記事1を投稿したユーザーでログインする
      sign_in(user: @user1)
      # 一覧ページに遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      # 記事1と記事2のカテゴリが一致しないこと
      while @experience_tag2.category_id == @experience_tag1.category_id
        @experience_tag1 = create_experience_tag(user_model: @user1)
      end
      within('main') do
        within('.search-items') do
          find('details').click
          # 検索条件 カテゴリ は以下と等しい に記事1の値を入力する
          select @experience_tag1.category.name, from: 'q_category_id_eq'
          # 検索する
          click_button '検索'
        end
      end
      # 記事1は検索に合致し、表示することを確認する
      confirm_show(model: @experience_tag1)
      # 記事2は検索に合致せず、表示しないことを確認する
      confirm_show_no_have(model: @experience_tag2)
    end
    it '経過日数の検索が合致する' do
      # 記事1を投稿したユーザーでログインする
      sign_in(user: @user1)
      # 一覧ページに遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      # 記事1と記事2の経過日数が一致しないこと
      @experience_tag1 = create_experience_tag(user_model: @user1) while @experience_tag2.period_id == @experience_tag1.period_id
      within('main') do
        within('.search-items') do
          find('details').click
          # 検索条件 経過日数 は以下と等しい に記事1の値を入力する
          select @experience_tag1.period.name, from: 'q_period_id_eq'
          # 検索する
          click_button '検索'
        end
      end
      # 記事1は検索に合致し、表示することを確認する
      confirm_show(model: @experience_tag1)
      # 記事2は検索に合致せず、表示しないことを確認する
      confirm_show_no_have(model: @experience_tag2)
    end
    it 'ユーザーの 住まいの最高気温 の検索が合致する' do
      # 記事1を投稿したユーザーでログインする
      sign_in(user: @user1)
      # 一覧ページに遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      # 記事1と記事2のユーザーの 住まいの最高気温が一致しないこと
      while @user2.high_id == @user1.high_id
        @user1 = FactoryBot.create(:user)
        @experience_tag1 = create_experience_tag(user_model: @user1)
      end
      within('main') do
        within('.search-items') do
          find('details').click
          # 検索条件 ユーザーの 住まいの最高気温 は以下と等しい に記事1の値を入力する
          select @experience_tag1.user.high.name, from: 'q_user_high_id_eq'
          # 検索する
          click_button '検索'
        end
      end
      # 記事1は検索に合致し、表示することを確認する
      confirm_show(model: @experience_tag1)
      # 記事2は検索に合致せず、表示しないことを確認する
      confirm_show_no_have(model: @experience_tag2)
    end
    it 'ユーザーの 住まいの最低気温 の検索が合致する' do
      # 記事1を投稿したユーザーでログインする
      sign_in(user: @user1)
      # 一覧ページに遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      # 記事1と記事2の ユーザーの 住まいの最低気温 が一致しないこと
      while @user2.low_id == @user1.low_id
        @user1 = FactoryBot.create(:user)
        @experience_tag1 = create_experience_tag(user_model: @user1)
      end
      within('main') do
        within('.search-items') do
          find('details').click
          # 検索条件 ユーザーの 住まいの最低気温 は以下と等しい に記事1の値を入力する
          select @experience_tag1.user.low.name, from: 'q_user_low_id_eq'
          # 検索する
          click_button '検索'
        end
      end
      # 記事1は検索に合致し、表示することを確認する
      confirm_show(model: @experience_tag1)
      # 記事2は検索に合致せず、表示しないことを確認する
      confirm_show_no_have(model: @experience_tag2)
    end
    it 'ユーザーの 同居人数 の検索が合致する' do
      # 記事1を投稿したユーザーでログインする
      sign_in(user: @user1)
      # 一覧ページに遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      # 記事1と記事2の ユーザーの 同居人数 が一致しないこと
      while @user2.housemate_id == @user1.housemate_id
        @user1 = FactoryBot.create(:user)
        @experience_tag1 = create_experience_tag(user_model: @user1)
      end
      within('main') do
        within('.search-items') do
          find('details').click
          # 検索条件 ユーザーの 同居人数 は以下と等しい に記事1の値を入力する
          select @experience_tag1.user.housemate.name, from: 'q_user_housemate_id_eq'
          # 検索する
          click_button '検索'
        end
      end
      # 記事1は検索に合致し、表示することを確認する
      confirm_show(model: @experience_tag1)
      # 記事2は検索に合致せず、表示しないことを確認する
      confirm_show_no_have(model: @experience_tag2)
    end
    it 'ユーザーの 趣味の多さ の検索が合致する' do
      # 記事1を投稿したユーザーでログインする
      sign_in(user: @user1)
      # 一覧ページに遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      # 記事1と記事2の ユーザーの 趣味の多さ が一致しないこと
      while @user2.hobby_id == @user1.hobby_id
        @user1 = FactoryBot.create(:user)
        @experience_tag1 = create_experience_tag(user_model: @user1)
      end
      within('main') do
        within('.search-items') do
          find('details').click
          # 検索条件 ユーザーの 趣味の多さ は以下と等しい に記事1の値を入力する
          select @experience_tag1.user.hobby.name, from: 'q_user_hobby_id_eq'
          # 検索する
          click_button '検索'
        end
      end
      # 記事1は検索に合致し、表示することを確認する
      confirm_show(model: @experience_tag1)
      # 記事2は検索に合致せず、表示しないことを確認する
      confirm_show_no_have(model: @experience_tag2)
    end
    it 'ユーザーの お店との距離  の検索が合致する' do
      # 記事1を投稿したユーザーでログインする
      sign_in(user: @user1)
      # 一覧ページに遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      # 記事1と記事2の ユーザーの お店との距離 が一致しないこと
      while @user2.range_with_store_id == @user1.range_with_store_id
        @user1 = FactoryBot.create(:user)
        @experience_tag1 = create_experience_tag(user_model: @user1)
      end
      within('main') do
        within('.search-items') do
          find('details').click
          # 検索条件 ユーザーの お店との距離 は以下と等しい に記事1の値を入力する
          select @experience_tag1.user.range_with_store.name, from: 'q_user_range_with_store_id_eq'
          # 検索する
          click_button '検索'
        end
      end
      # 記事1は検索に合致し、表示することを確認する
      confirm_show(model: @experience_tag1)
      # 記事2は検索に合致せず、表示しないことを確認する
      confirm_show_no_have(model: @experience_tag2)
    end
    it 'ユーザーの 現在の状況  の検索が合致する' do
      # 記事1を投稿したユーザーでログインする
      sign_in(user: @user1)
      # 一覧ページに遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      # 記事1と記事2の ユーザーの 現在の状況 が一致しないこと
      while @user2.clean_status_id == @user1.clean_status_id
        @user1 = FactoryBot.create(:user)
        @experience_tag1 = create_experience_tag(user_model: @user1)
      end
      within('main') do
        within('.search-items') do
          find('details').click
          # 検索条件 ユーザーの 現在の状況 は以下と等しい に記事1の値を入力する
          select @experience_tag1.user.clean_status.name, from: 'q_user_clean_status_id_eq'
          # 検索する
          click_button '検索'
        end
      end
      # 記事1は検索に合致し、表示することを確認する
      confirm_show(model: @experience_tag1)
      # 記事2は検索に合致せず、表示しないことを確認する
      confirm_show_no_have(model: @experience_tag2)
    end
  end
  context '検索に合致するものがないとき' do
    it '記事はあるが、検索条件に合致しないとき' do
      # 記事1を投稿したユーザーでログインする
      sign_in(user: @user1)
      # 一覧ページに遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      within('main') do
        within('.search-items') do
          # 検索条件 テキスト検索 に記事1の値を入力する
          fill_in 'テキスト検索', with: "test-data #{@experience_tag1.title}"
          # 検索する
          click_button '検索'
        end
      end
      # 記事1は検索に合致せず、表示しないことを確認する
      within('main') do
        within('.cards') do
          expect(page).to have_no_link(@experience_tag1.user.nickname, href: user_path(@experience_tag1.user))
          expect(page).to have_no_link(@experience_tag1.title, href: experience_path(@experience_tag1))
          expect(page).to have_no_content(@experience_tag1.stress)
        end
      end
      # 記事2は検索に合致せず、表示しないことを確認する
      within('main') do
        within('.cards') do
          expect(page).to have_no_link(@experience_tag2.user.nickname, href: user_path(@experience_tag2.user))
          expect(page).to have_no_link(@experience_tag2.title, href: experience_path(@experience_tag2))
          expect(page).to have_no_content(@experience_tag2.stress)
        end
      end
      # 「記事がありません。」と表示すること
      within('main') do
        expect(page).to have_content('記事がありません。')
      end
    end
    it '記事がないとき' do
      skip('記事の投稿 投稿ができるとき ログインしたユーザーは新規投稿できる で実施のため')
    end
  end
  context 'ソート条件を変更できる' do
    it '更新日時 降順(デフォルト)' do
      # 記事1を投稿したユーザーでログインする
      sign_in(user: @user1)
      # 一覧ページに遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      # 記事の順が更新日時の降順に並んでいること
      within('main') do
        within('.cards') do
          expect(all('.card')[0]).to have_content(@experience_tag2.updated_at.strftime('%Y/%m/%d %H:%M:%S'))
          expect(all('.card')[1]).to have_content(@experience_tag1.updated_at.strftime('%Y/%m/%d %H:%M:%S'))
        end
      end
    end
    it '更新日時 昇順' do
      # 記事1を投稿したユーザーでログインする
      sign_in(user: @user1)
      # 一覧ページに遷移したことを確認する
      expect(current_path).to eq(experiences_path)
      # 記事の順を更新日時 昇順に変更する
      within('main') do
        within('.search-items') do
          find('details').click
          # 検索条件 ユーザーの お店との距離 は以下と等しい に記事1の値を入力する
          select '更新日時 昇順', from: 'q_sorts'
          # 検索する
          click_button '検索'
        end
      end
      within('main') do
        within('.cards') do
          expect(all('.card')[0]).to have_content(@experience_tag1.updated_at.strftime('%Y/%m/%d %H:%M:%S'))
          expect(all('.card')[1]).to have_content(@experience_tag2.updated_at.strftime('%Y/%m/%d %H:%M:%S'))
        end
      end
    end
  end
end
