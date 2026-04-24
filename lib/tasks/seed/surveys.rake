# frozen_string_literal: true

namespace :db do
  namespace :seed do
    desc "Surveys"
    # task surveys: :environment do
    task :surveys, [:user_id] => [:environment] do |_task, args|
      puts "Seeding Surveys..."
      Survey::Answer.destroy_all
      Survey::Response.destroy_all
      Survey::ScoreRangeStep.destroy_all
      Survey::AnswerOption.destroy_all
      Survey::Question.destroy_all
      Survey::Category.destroy_all
      Survey.destroy_all

      user = if args[:user_id].present?
        args[:user_id]
        User.find(args[:user_id])
      else
        existing_user = User.find_by(email: "admin@email.com", admin: true)
        existing_user.present? ? existing_user : FactoryBot.create(:user, first_name: "Admin", last_name: "McAdmins", email: "admin@email.com", admin: true)
      end

      survey = Survey.create!(
        user_id: user.id,
        name: "Depression Checklist",
        description: "A survey to track symptoms of depression over time.",
        published: true,
        available_to_public: false
      )

      # Category & Questions for Thoughts
      thoughts_category = survey.categories.create!(
        name: "Thoughts and Feelings",
        position: 1
      )
      thoughts_category.questions.create!(
        text: "I feel sad or down in the dumps.",
        position: 1
      )
      thoughts_category.questions.create!(
        text: "I have lost interest in my usual activities.",
        position: 2
      )

      # Category & Questions for Activities and Personal Relationships
      activities_category = survey.categories.create!(
        name: "Activities and Personal Relationships",
        position: 2
      )

      activities_category.questions.create!(
        text: "Loss of motivation or initiative.",
        position: 1
      )

      activities_category.questions.create!(
        text: "Loss of interest in family or friends",
        position: 2
      )

      # Category & Questions for Physical Symptoms
      physical_category = survey.categories.create!(
        name: "Physical Symptoms",
        position: 3
      )

      physical_category.questions.create!(
        text: "I have trouble sleeping at night.",
        position: 1
      )

      physical_category.questions.create!(
        text: "Worrying about health",
        position: 2
      )

      # Answer Options for all questions
      survey.answer_options.create!(value: 0, name: "Not at all")
      survey.answer_options.create!(value: 1, name: "Somewhat")
      survey.answer_options.create!(value: 2, name: "Moderately")
      survey.answer_options.create!(value: 3, name: "A Lot")
      survey.answer_options.create!(value: 4, name: "Extremely")

      # Score Ranges for the survey
      survey.score_range_steps.create!(name: "No Depression", position: 1, description: "Your responses indicate that you are not currently experiencing symptoms of depression.")
      survey.score_range_steps.create!(name: "Normal but unhappy", position: 2, description: "Your responses indicate that you are experiencing some negative feelings but not to a significant extent.")
      survey.score_range_steps.create!(name: "Mild Depression", position: 3, description: "Your responses indicate that you are experiencing some symptoms of depression.")
      survey.score_range_steps.create!(name: "Moderate Depression", position: 4, description: "Your responses indicate that you are experiencing moderate symptoms of depression.")
      survey.score_range_steps.create!(name: "Severe Depression", position: 5, description: "Your responses indicate that you are experiencing severe symptoms of depression.")
      survey.score_range_steps.create!(name: "Extreme Depression", position: 6, description: "Your responses indicate that you are experiencing extreme symptoms of depression.")

      survey.calculate_score_range_steps_points
      puts "Finished seeding surveys."
    end

    task :survey_responses, [:user_id, :survey_id] => [:environment] do |_task, args|
      puts "Seeding Survey Responses..."
      Survey::Response.destroy_all

      user = if args[:user_id].present?
        args[:user_id]
        User.find(args[:user_id])
      else
        existing_user = User.find_by(email: "admin@email.com", admin: true)
        existing_user.present? ? existing_user : FactoryBot.create(:user, first_name: "Admin", last_name: "McAdmins", email: "admin@email.com", admin: true)
      end

      survey = if args[:survey_id].present?
        args[:survey_id]
        Survey.find(args[:survey_id])
      else
        Survey.first
      end

      3.times do |i|
        response = survey.responses.create!(
          user_id: user.id,
          occurred_at: (i * 5).days.ago
        )

        survey.questions.each do |question|
          response.answers.create!(
            survey_question_id: question.id,
            survey_answer_option_id: survey.answer_options.sample.id
          )
        end
      end

      puts "Finished seeding survey responses."
    end
  end
end
