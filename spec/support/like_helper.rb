module LikeHelper
  def confirm_index(model:, card_number: 0, like_count: 0, imitate_count: 0)
    within('main') do
      all('.card')[card_number] do
        expect(page).to have_link(model.title, href: experience_path(model))
        expect(all('tr')[5]).to have_content("#{like_count} いいね")
        expect(all('tr')[6]).to have_content("#{imitate_count} 真似した")
      end
    end
  end

  def confirm_show(model:, like_count: 0, imitate_count: 0)
    within('main') do
      within('.card') do
        expect(page).to have_link(model.title, href: experience_path(model))
        expect(all('tr')[5]).to have_content("#{like_count} いいね")
        expect(all('tr')[6]).to have_content("#{imitate_count} 真似した")
      end
    end
  end

  def confirm_like_button(status: true)
    within('main') do
      within('.like') do
        expect(find('input[name="experiences_like[like]"]', visible: false).value).to eq(status.to_s)
      end
    end
  end

  def confirm_imitate_button(status: true)
    within('main') do
      within('.like') do
        expect(find('input[name="experiences_like[imitate]"]', visible: false).value).to eq(status.to_s)
      end
    end
  end

  def click_change_button(button_number: 0, change_count: 0)
    within('main') do
      within('.like') do
        expect do
          all('button')[button_number].click
        end.to change { ExperienceLike.count }.by(change_count)
      end
    end
  end

  def confirm_header_notice_like(user:, experience_tag:, notice_count: 0)
    within('header') do
      within('nav') do
        within('.notice') do
          expect(find('span').text).to eq(notice_count.to_s)
          find('span').hover
          expect(page).to have_content("#{user.nickname} が、あなたの記事「#{experience_tag.title}」に「いいね」しました")
        end
      end
    end
  end

  def confirm_mypage_notice_like(user:, experience_tag:)
    within('main') do
      expect(page).to have_content("#{user.nickname} が、あなたの記事「#{experience_tag.title}」に「いいね」しました")
    end
  end

  def confirm_header_notice_imitate(user:, experience_tag:, notice_count: 0)
    within('header') do
      within('nav') do
        within('.notice') do
          expect(find('span').text).to eq(notice_count.to_s)
          find('span').hover
          expect(page).to have_content("#{user.nickname} が、あなたの記事「#{experience_tag.title}」に「真似した」しました")
        end
      end
    end
  end

  def confirm_mypage_notice_imitate(user:, experience_tag:)
    within('main') do
      expect(page).to have_content("#{user.nickname} が、あなたの記事「#{experience_tag.title}」に「真似した」しました")
    end
  end
end
