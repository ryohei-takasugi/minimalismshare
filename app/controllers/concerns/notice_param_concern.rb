require 'active_support'

module NoticeParamConcern
  extend ActiveSupport::Concern

  def set_notice_params(model, str)
    notice_params = {}
    notice_params[:message] = "#{model.user.nickname} が、あなたの記事「#{model.experience.title}」に「#{str}」しました"
    notice_params[:url]     = experience_path(model.experience.id)
    notice_params[:user_id] = model.experience.user_id
    notice_params
  end
end