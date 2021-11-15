require 'rails_helper'

RSpec.describe 'コメント投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @experience_tag = create_experience_tag(user_model: @user)
    @comment = Faker::Lorem.sentence
  end
  it 'ログインしたユーザーは記事閲覧ページでコメント投稿できる' do
    # ログインする
    sign_in(user: @user)
    # 閲覧ページへのリンクをクリックする
    click_link(@experience_tag.title)
    # 閲覧ページに遷移することを確認する
    expect(current_path).to eq(experience_path(@experience_tag))
    within('.comment') do
      # フォームに情報を入力する
      fill_in 'experience_comment[comment]', with: @comment
      # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { ExperienceComment.count }.by(1)
      # 詳細ページにリダイレクトされることを確認する
      expect(current_path).to eq(experience_path(@experience_tag))
      # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
      expect(page).to have_content(@comment)
    end
    # 「コメントを追加しました」の文字があることを確認する
    expect(page).to have_content('コメントを追加しました')
  end
end

RSpec.describe 'コメント編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @experience_tag = create_experience_tag(user_model: @user)
    @comment = Faker::Lorem.sentence
  end
  it 'ログインしたユーザーは記事閲覧ページでコメントを編集できる' do
    # ログインする
    sign_in(user: @user)
    # 閲覧ページへのリンクをクリックする
    click_link(@experience_tag.title)
    # 閲覧ページに遷移することを確認する
    expect(current_path).to eq(experience_path(@experience_tag))
    within('.comment') do
      # フォームに情報を入力する
      fill_in 'experience_comment[comment]', with: @comment
      # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { ExperienceComment.count }.by(1)
      # 詳細ページ下部に先ほどのコメント内容が含まれていることを確認する
      expect(page).to have_content(@comment)
      # コメントの編集ボタンを押す
      click_link('編集')
      # 投稿済みの内容がフォームに入っていることを確認する
      expect(find('#experience_comment_comment').value).to eq(@comment)
      # フォームに情報を入力する
      fill_in 'experience_comment[comment]', with: "#{@comment}edit"
      # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { ExperienceComment.count }.by(0)
      # 詳細ページにリダイレクトされることを確認する
      expect(current_path).to eq(experience_path(@experience_tag))
      # 詳細ページ下部に先ほどのコメント内容が含まれていることを確認する
      expect(page).to have_content("#{@comment}edit")
    end
    # 「コメントを更新しました」の文字があることを確認する
    expect(page).to have_content('コメントを更新しました')
  end
end

RSpec.describe 'コメント削除', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @experience_tag = create_experience_tag(user_model: @user)
    @comment = Faker::Lorem.sentence
  end
  it 'ログインしたユーザーは記事閲覧ページでコメントを削除できる' do
    # ログインする
    sign_in(user: @user)
    # 閲覧ページへのリンクをクリックする
    click_link(@experience_tag.title)
    # 閲覧ページに遷移することを確認する
    expect(current_path).to eq(experience_path(@experience_tag))
    within('.comment') do
      # フォームに情報を入力する
      fill_in 'experience_comment[comment]', with: @comment
      # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { ExperienceComment.count }.by(1)
      # 詳細ページ下部に先ほどのコメント内容が含まれていることを確認する
      expect(page).to have_content(@comment)
      # コメントを送信すると、Commentモデルのカウントが1下がることを確認する
      expect do
        page.accept_confirm('この操作は取り消すことができません。本当にコメントの削除を実行しますか?') do
          click_link('削除')
        end
        sleep 0.5 # データベース削除までに少し時間が必要
      end.to change { ExperienceComment.count }.by(-1)
      # 詳細ページにリダイレクトされることを確認する
      expect(current_path).to eq(experience_path(@experience_tag))
      # 詳細ページ下部に先ほどのコメント内容が含まれていないことを確認する
      expect(page).to have_no_content(@comment)
    end
    # 「コメントを削除しました」の文字があることを確認する
    expect(page).to have_content('コメントを削除しました')
  end
end
