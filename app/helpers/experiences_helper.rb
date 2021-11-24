module ExperiencesHelper
  # used
  #   experiences/index -> shared/_show_experience.html
  #   experiences/show  -> shared/_show_experience.html
  #   user/:id          -> shared/_show_experience.html
  def user_liked?(experience)
    if check_likes_no_blank(experience.experience_likes)
      experience.experience_likes.where(user_id: current_user.id).first.like
    end
  end

  def user_imitated?(experience)
    if check_likes_no_blank(experience.experience_likes)
      experience.experience_likes.where(user_id: current_user.id).first.imitate
    end
  end

  def check_likes_no_blank(experience_likes)
    unless experience_likes.blank?
      unless experience_likes.where(user_id: current_user.id).blank?
        return true
      end
    end
    return false
  end

  def count_liked(like_group_list, experience)
    like_group_list.blank? || like_group_list[experience.id].nil? ? 0 : like_group_list[experience.id]
  end

  def count_imitated(imitate_group_list, experience)
    imitate_group_list.blank? || imitate_group_list[experience.id].nil? ? 0 : imitate_group_list[experience.id]
  end

  def join_tags(tags)
    if tags.blank? then nil
    elsif tags.instance_of?(Array)  then tags.join('、')
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
