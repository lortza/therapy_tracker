# frozen_string_literal: true

require "rails_helper"

class TestSortableObject < ApplicationRecord
  self.table_name = "test_sortable_objects"
  extend Sortable
end

RSpec.describe Sortable, type: :concern do
  before(:all) do
    ActiveRecord::Schema.define do
      create_table :test_sortable_objects, force: true do |t|
        t.string :name
      end
    end
  end

  after(:all) do
    ActiveRecord::Schema.define do
      drop_table :test_sortable_objects, if_exists: true
    end
  end

  describe ".by_name" do
    before do
      TestSortableObject.create!(name: "c")
      TestSortableObject.create!(name: "B")
      TestSortableObject.create!(name: "a")
    end

    it "returns records ordered by name in ascending order" do
      results = TestSortableObject.by_name
      expect(results.pluck(:name)).to eq(["a", "B", "c"])
    end

    it "is case insensitive" do
      results = TestSortableObject.by_name
      expect(results.pluck(:name)).to eq(["a", "B", "c"])
    end
  end
end
