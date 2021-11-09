# frozen_string_literal: true

class EasyButton < ApplicationRecord
  belongs_to :user
  belongs_to :pain
  belongs_to :body_part
end
