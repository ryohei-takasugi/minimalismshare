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

  def count_liked(likes_count, experience)
    likes_count.blank? || likes_count[experience.id].nil? ? 0 : likes_count[experience.id]
  end

  def count_imitated(imitates_count, experience)
    imitates_count.blank? || imitates_count[experience.id].nil? ? 0 : imitates_count[experience.id]
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
