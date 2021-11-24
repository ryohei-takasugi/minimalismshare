module UsersHelper
  # used
  #   devise/registrations/new
  def set_high
    High.all
  end

  def set_low
    Low.all
  end

  def set_housemate
    Housemate.all
  end

  def set_hobby
    Hobby.all
  end

  def set_clean_status
    CleanStatus.all
  end

  def set_range_with_store
    RangeWithStore.all
  end
end
