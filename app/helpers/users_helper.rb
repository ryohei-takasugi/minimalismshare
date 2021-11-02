module UsersHelper
  def set_region
    Region.all
  end

  def set_climate
    Climate.all
  end

  def set_housemate
    Housemate.all
  end

  def set_children
    Children.all
  end

  def set_cleanStatus
    CleanStatus.all
  end
end
