# frozen_string_literal: true

require "rails_helper"

class TestSearchableObject < ApplicationRecord
  self.table_name = "test_searchable_objects"
  extend Searchable
end

RSpec.describe Searchable, type: :concern do
  before(:all) do
    ActiveRecord::Schema.define do
      create_table :test_searchable_objects, force: true do |t|
        t.string :name
      end
    end
  end

  after(:all) do
    ActiveRecord::Schema.define do
      drop_table :test_searchable_objects, if_exists: true
    end
  end

  describe ".search" do
    before do
      TestSearchableObject.create!(name: "Ace")
      TestSearchableObject.create!(name: "Beet")
      TestSearchableObject.create!(name: "Gamma")
    end

    it "returns all records when terms are blank" do
      results = TestSearchableObject.search("")
      expect(results.count).to eq(3)
    end

    it "returns matching records when terms are provided" do
      results = TestSearchableObject.search("e")
      expect(results.count).to eq(2)
      expect(results.pluck(:name)).to include("Ace", "Beet")
    end

    it "is case insensitive" do
      results = TestSearchableObject.search("ACE")
      expect(results.count).to eq(1)
      expect(results.first.name).to eq("Ace")
    end

    it "returns an empty result when no matches are found" do
      results = TestSearchableObject.search("Delta")
      expect(results.count).to eq(0)
    end
  end
end
