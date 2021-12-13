module ShowExperienceHelper
  def edit_show(model:)
    fill_in 'タイトル', with: set_str_edit(@experience_tag1.title)
    fill_in 'experience_tag[tags]', with: "#{set_tags_list(@experience_tag1.tags).join('、')}、#{add_str}"
    fill_in 'ストレス', with: set_str_edit(@experience_tag1.stress)
    select edit_category(model).name, from: 'experience_tag_category_id'
    select edit_period(model).name, from: 'experience_tag_period_id'
    fill_in_rich_text_area nil, with: "#{@experience_tag1.content}#{add_str}"
  end

  def confirm_show(model:, edit: false)
    nickname         = model.user.nickname
    dream            = model.user.dream
    high             = model.user.high.name
    low              = model.user.low.name
    housemate        = model.user.housemate.name
    hobby            = model.user.hobby.name
    range_with_store = model.user.range_with_store.name
    clean_status     = model.user.clean_status.name
    title            = model.title
    tags_list        = set_tags_list(model.tags)
    stress           = model.stress
    category         = model.category.name
    period           = model.period.name
    if edit
      title     = set_str_edit(title)
      tags_list = tags_list << add_str
      stress    = set_str_edit(stress)
      category  = edit_category(model).name
      period    = edit_period(model).name
    end
    within('main') do
      within('.card') do
        within('.nickname') do
          expect(page).to have_link(nickname, href: user_path(model.user))
        end
        within('.title') do
          expect(page).to have_link(title, href: experience_path(model))
        end
        expect(all('tr')[0]).to have_content(dream)
        expect(all('tr')[0]).to have_content(high)
        expect(all('tr')[0]).to have_content(low)
        expect(all('tr')[0]).to have_content(housemate)
        expect(all('tr')[0]).to have_content(hobby)
        expect(all('tr')[0]).to have_content(range_with_store)
        expect(all('tr')[0]).to have_content(clean_status)
        expect(all('tr')[2]).to have_content(stress)
        expect(all('tr')[3]).to have_content(category)
        expect(all('tr')[4]).to have_content(period)
        expect(tags_list.size).to be >= 1
        tags_list.each do |tag_name|
          expect(all('tr')[1]).to have_content(tag_name)
        end
      end
    end
  end

  def confirm_show_no_have(model:)
    nickname         = model.user.nickname
    title            = model.title
    stress           = model.stress
    within('main') do
      within('.card') do
        within('.nickname') do
          expect(page).to have_no_link(nickname, href: user_path(model.user))
        end
        within('.title') do
          expect(page).to have_no_link(title, href: experience_path(model))
        end
        expect(all('tr')[2]).to have_no_content(stress)
      end
    end
  end

  def confirm_content(model:)
    within('main') do
      within('.content') do
        expect(page).to have_content(model.content.body.to_plain_text.gsub(/\n/, '').strip)
      end
    end
  end

  def confirm_content_no_have(model:)
    within('main') do
      within('.content') do
        expect(page).to have_no_content(model.content.body.to_plain_text.gsub(/\n/, '').strip)
      end
    end
  end

  private

  def add_str
    'edit'
  end

  def set_tags_list(tags)
    if tags.instance_of?(Array)
      result = tags
    elsif tags.instance_of?(String)
      result = tags.split('、')
    else
      result = tags.map { |tag| tag.name }
    end
    result[0..8]
  end

  def set_str_edit(str)
    result = str[0..95]
    result << add_str
    result
  end

  def edit_category(model)
    if model.category_id.to_i >= 3
      Category.find(1)
    else
      Category.find(model.category_id.to_i + 1)
    end
  end

  def edit_period(model)
    if model.period_id.to_i >= 7
      Period.find(1)
    else
      Period.find(model.period_id.to_i + 1)
    end
  end
end
