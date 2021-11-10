module ExperiencesHelper
  # used
  #   experiences/new
  def set_tag
    Tag.all
  end

  def set_category
    Category.all
  end

  def set_period
    Period.all
  end

  # used
  #   experiences/index
  def set_sort
    [
      ['更新日時 降順', 'updated_at desc'],
      ['更新日時 昇順', 'updated_at asc']
    ]
  end

  # used
  #   experiences/index -> shared/_show_experience.html
  #   experiences/show  -> shared/_show_experience.html
  #   user/:id          -> shared/_show_experience.html
  def user_liked?(experience)
    if !experience.experience_likes.blank? && !experience.experience_likes.where(user_id: current_user.id).blank?
      experience.experience_likes.where(user_id: current_user.id).first.like ? true : false
    end
  end

  def user_imitated?(experience)
    if !experience.experience_likes.blank? && !experience.experience_likes.where(user_id: current_user.id).blank?
      experience.experience_likes.where(user_id: current_user.id).first.imitate ? true : false
    end
  end

  def experience_count_group_liked(like_group_list, experience)
    like_group_list.blank? || like_group_list[experience.id].nil? ? 0 : like_group_list[experience.id]
  end

  def experience_count_group_imitated(imitate_group_list, experience)
    imitate_group_list.blank? || imitate_group_list[experience.id].nil? ? 0 : imitate_group_list[experience.id]
  end

  def tags_join(tags)
    if tags.blank? then nil
    elsif tags.instance_of?(Array)  then tags.join(', ')
    elsif tags.instance_of?(String) then tags
    else
      tags.map { |tag| tag.name }.join('、')
    end
  end

  # used
  #   experiences/show
  def confirm_author?(model)
    model.user_id == current_user.id
  end
end
