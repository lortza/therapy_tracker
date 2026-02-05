# frozen_string_literal: true

# == Schema Information
#
# Table name: dummy_records
#
#  id         :bigint           not null, primary key
#  data       :jsonb
#  notes      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class DummyRecord < ApplicationRecord
end
