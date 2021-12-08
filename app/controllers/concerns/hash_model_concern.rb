require 'active_support'

module HashModelConcern
  extend ActiveSupport::Concern

  # Set hash model
  def set_hash_user
    {
      high: High.all,
      low: Low.all,
      housemate: Housemate.all,
      hobby: Hobby.all,
      clean_status: CleanStatus.all,
      range_with_store: RangeWithStore.all
    }
  end

  def set_hash_exprience
    {
      tag: Tag.all,
      category: Category.all,
      period: Period.all,
      sort: set_sort
    }
  end

  private

  def set_sort
    [
      ['作成日時 降順', 'created_at desc'],
      ['作成日時 昇順', 'created_at asc'],
      ['更新日時 降順', 'updated_at desc'],
      ['更新日時 昇順', 'updated_at asc']
    ]
  end
end
