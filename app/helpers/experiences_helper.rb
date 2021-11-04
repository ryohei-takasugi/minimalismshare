module ExperiencesHelper
  # model
  def set_tag
    Tag.all
  end

  def set_category
    Category.all
  end

  def set_period
    Period.all
  end

  def set_sort
    [
      ['更新日時 降順', 'updated_at desc'],
      ['更新日時 昇順', 'updated_at asc']
    ]
  end

  # method
  def confirm_author?(model)
    model.user_id == current_user.id
  end

  def tags_join(tags)
    if tags.blank? then nil
    elsif tags.instance_of?(Array)  then tags.join(', ')
    elsif tags.instance_of?(String) then tags
    else
      tags.map { |tag| tag.name }.join('、')
    end
  end
end
