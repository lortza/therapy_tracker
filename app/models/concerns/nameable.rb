# frozen_string_literal: true

module Nameable
  # class methods for Exercise/Pain/BodyPart models
  def by_name
    order(Arel.sql("lower(name) ASC"))
  end

  def search(terms)
    if terms.blank?
      all
    else
      where("name ILIKE ?", "%#{terms}%")
    end
  end
end
