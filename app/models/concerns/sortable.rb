# frozen_string_literal: true

module Sortable
  def by_name
    order(Arel.sql("lower(name) ASC"))
  end
end
