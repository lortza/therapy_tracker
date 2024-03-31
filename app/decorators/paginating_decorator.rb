# frozen_string_literal: true

# This delegates to gem will_paginate so we can paginate the decorator collection
class PaginatingDecorator < Draper::CollectionDecorator
  delegate :current_page, :per_page, :offset, :total_entries, :total_pages
end