# frozen_string_literal: true

json.array! @pains, partial: 'pains/pain', as: :pain
