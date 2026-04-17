# frozen_string_literal: true

namespace :db do
  namespace :seed do
    desc "Surveys"
    task surveys: :environment do
      puts "Seeding Surveys..."
      Survey::Answer.destroy_all
      Survey::Response.destroy_all
      Survey::ScoreRange.destroy_all
      Survey::AnswerOption.destroy_all
      Survey::Question.destroy_all
      Survey::Category.destroy_all
      Survey.destroy_all

      survey = Survey.create!(
        name: "Depression Checklist",
        description: "A survey to track symptoms of depression over time.",
        published: true
      )

      # Category & Questions for Thoughts
      thoughts_category = survey.categories.create!(
        name: "Thoughts and Feelings",
        position: 0
      )
      thoughts_category.questions.create!(
        text: "I feel sad or down in the dumps.",
        position: 0
      )
      thoughts_category.questions.create!(
        text: "I have lost interest in my usual activities.",
        position: 1
      )

      # Category & Questions for Activities and Personal Relationships
      activities_category = survey.categories.create!(
        name: "Activities and Personal Relationships",
        position: 1
      )

      activities_category.questions.create!(
        text: "Loss of motivation or initiative.",
        position: 0
      )

      activities_category.questions.create!(
        text: "Loss of interest in family or friends",
        position: 1
      )

      # Category & Questions for Physical Symptoms
      physical_category = survey.categories.create!(
        name: "Physical Symptoms",
        position: 2
      )

      physical_category.questions.create!(
        text: "I have trouble sleeping at night.",
        position: 0
      )

      physical_category.questions.create!(
        text: "Worrying about health",
        position: 1
      )

      # Answer Options for all questions
      survey.answer_options.create!(value: 0, name: "Not at all")
      survey.answer_options.create!(value: 1, name: "Somewhat")
      survey.answer_options.create!(value: 2, name: "Moderately")
      survey.answer_options.create!(value: 3, name: "A Lot")
      survey.answer_options.create!(value: 4, name: "Extremely")

      # Score Ranges for the survey
      survey.score_ranges.create!(name: "No Depression", range_min_value: 0, range_max_value: 5)
      survey.score_ranges.create!(name: "Normal but unhappy", range_min_value: 6, range_max_value: 10)
      survey.score_ranges.create!(name: "Mild Depression", range_min_value: 11, range_max_value: 25)
      survey.score_ranges.create!(name: "Moderate Depression", range_min_value: 26, range_max_value: 50)
      survey.score_ranges.create!(name: "Severe Depression", range_min_value: 51, range_max_value: 75)
      survey.score_ranges.create!(name: "Extreme Depression", range_min_value: 76, range_max_value: 100)

      puts "Finished seeding surveys."
    end
  end
end
