module SignHelper
  def sign_up(user:)
    basic_visit new_user_registration_path
    fill_in 'ニックネーム', with: user.nickname
    fill_in 'Eメール', with: user.email
    fill_in 'パスワード', with: user.password
    fill_in '確認用', with: user.password_confirmation
    fill_in '夢・目標', with: user.dream
    select user.high.name, from: 'user_high_id'
    select user.low.name, from: 'user_low_id'
    select user.housemate.name, from: 'user_housemate_id'
    select user.hobby.name, from: 'user_hobby_id'
    select user.range_with_store.name, from: 'user_range_with_store_id'
    select user.clean_status.name, from: 'user_clean_status_id'
    find('input[name="commit"]').click
  end
  def sign_in(user:)
    basic_visit new_user_session_path
    fill_in 'Eメール', with: user.email
    fill_in 'パスワード', with: user.password
    find('input[name="commit"]').click
  end
end