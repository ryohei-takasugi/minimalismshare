module ExperiencesHelper
  def tags_join(tags)
    array = []
    tags.each do |tag|
      array << tag.name
    end
    array.join('、')
  end

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
end
