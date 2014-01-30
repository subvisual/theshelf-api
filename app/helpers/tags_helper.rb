module TagsHelper
  def star_tag(rating_value: nil, star_value: nil)
    if rating_value.to_f > star_value - 1
      painted_star_tag(rating_value: rating_value, star_value: star_value)
    else
      empty_star_tag(rating_value: rating_value)
    end
  end

  private
  def painted_star_tag(rating_value: nil, star_value: nil)
    if rating_value.to_f >= star_value
      full_star_tag(rating_value: rating_value)
    else
      half_star_tag(rating_value: rating_value)
    end
  end

  def full_star_tag(rating_value: nil)
    content_tag(:label, "", { class: 'rating-label full', title: rating_value.to_f })
  end

  def half_star_tag(rating_value: nil)
    content_tag(:label, "", { class: 'rating-label half', title: rating_value.to_f })
  end

  def empty_star_tag(rating_value: nil)
    content_tag(:label, "", { class: 'rating-label', title: rating_value.to_f })
  end
end
