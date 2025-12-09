# frozen_string_literal: true

module Searchable
  def search(terms)
    if terms.blank?
      all
    else
      where("name ILIKE ?", "%#{terms}%")
    end
  end
end
