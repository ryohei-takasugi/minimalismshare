require 'active_support'

module NoticeConcern
  extend ActiveSupport::Concern
  
  def create_notice(model)
    notice = nil
    case model.model_name.name
    when "ExperienceComment"
      notice = Notice.new(set_params_notice(model, 'コメント'))
    when "ExperienceLike"
      notice = Notice.new(set_params_notice(model, select_action)) unless select_action.nil?
    end
    notice.save unless notice.nil?
  end

  def read_notice(user_id)
    user_notice = Notice.where(user_id: user_id)
    user_notice.update(read: true)
  end

  def set_instance_notice_recent(user_id)
    Notice.recent(user_id)
  end

  private

  def set_params_notice(model, str)
    notice_params = {}
    notice_params[:message] = "#{model.user.nickname} が、あなたの記事「#{model.experience.title}」に #{str}しました"
    notice_params[:url]     = experience_path(model.experience.id)
    notice_params[:user_id] = model.experience.user_id
    notice_params
  end

  def select_action
    if set_params_update_like.include?(:like) && set_params_update_like[:like].match(/(true|True|TRUE)/)
      action = '「いいね」'
    elsif set_params_update_like.include?(:imitate) && set_params_update_like[:imitate].match(/(true|True|TRUE)/)
      action = '「真似した」'
    else
      action = nil
    end
  end
end