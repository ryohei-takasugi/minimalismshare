module UsersHelper
  # used
  #   
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


  # used
  #   experiences/index
  def select_high(id)
    High.find(id)
  end

  def select_low(id)
    Low.find(id)
  end

  def select_housemate(id)
    Housemate.find(id)
  end

  def select_hobby(id)
    Hobby.find(id)
  end

  def select_clean_status(id)
    CleanStatus.find(id)
  end

  def select_range_with_store(id)
    RangeWithStore.find(id)
  end
end
