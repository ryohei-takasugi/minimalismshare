module ExperiencesHelper
  def tags_join(tags)
    # <% experience.tags.each do |tag| %>
    #   <p class="tag"><%= tag.name %></p>
    # <% end %>
    array = Array.new
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
end
