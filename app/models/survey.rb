# frozen_string_literal: true

# == Schema Information
#
# Table name: surveys
#
#  id                             :uuid             not null, primary key
#  available_to_public            :boolean          default(FALSE), not null
#  calculated_question_max_points :integer
#  calculated_question_min_points :integer
#  description                    :text
#  name                           :string           not null
#  published                      :boolean          default(FALSE), not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  user_id                        :bigint
#
# Indexes
#
#  index_surveys_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Survey < ApplicationRecord
  # A Survey is a way for a user to track their symptoms on a specific topic over time.
  # For example, an admin might create a "Depression Survey" with questions about mood,
  # sleep, appetite, etc. The user can then fill out the survey on a regular basis to track
  # their symptoms and share the results with their therapist.

  belongs_to :author, class_name: "User", optional: true, foreign_key: "user_id"

  has_many :categories, -> { order(:position) }, class_name: "Survey::Category", dependent: :destroy
  has_many :questions, -> { order(:position) }, through: :categories, class_name: "Survey::Question"
  has_many :answer_options, -> { order(:value) }, class_name: "Survey::AnswerOption", dependent: :destroy
  has_many :score_range_steps, -> { order(:position) }, class_name: "Survey::ScoreRangeStep", dependent: :destroy

  has_many :enrollments, class_name: "Survey::Enrollment", foreign_key: "survey_id", dependent: :destroy
  has_many :enrolled_users, through: :enrollments, source: :user
  has_many :responses, class_name: "Survey::Response", foreign_key: "survey_id", dependent: :destroy

  normalizes :name, with: ->(name) { name.strip.squish }
  validates :name,
    presence: true,
    uniqueness: {case_sensitive: false}

  validates :calculated_question_min_points,
    numericality: {only_integer: true, greater_than_or_equal_to: 0},
    allow_nil: true

  validates :calculated_question_max_points,
    numericality: {only_integer: true, greater_than_or_equal_to: :calculated_question_min_points},
    allow_nil: true

  scope :published, -> { where(published: true) }
  scope :available_to_public, -> { where(available_to_public: true) }

  def max_score
    @max_score ||= questions.size * calculated_question_max_points
  end

  # TODO: determine when this method should be called and implement that.
  # This should likely be called after any changes to questions, answer options, or score
  # range steps, and should likely also be called as part of a publish action for the survey.
  def calculate_score_range_steps_points
    score_range_steps.update_all(calculated_range_min_points: nil, calculated_range_max_points: nil)
    num_steps = score_range_steps.ordered.size

    raise ArgumentError, "Survey is missing score range steps" if num_steps.zero?
    raise ArgumentError, "Survey is missing a max score" if max_score.nil?

    total_positions = max_score - calculated_question_min_points + 1
    base_size = total_positions / num_steps
    remainder = total_positions % num_steps

    current_min = calculated_question_min_points

    score_range_steps.ordered.each_with_index do |step, index|
      step_size = base_size + ((index < remainder) ? 1 : 0)
      step.update!(calculated_range_min_points: current_min, calculated_range_max_points: current_min + step_size - 1)
      current_min += step_size
    end
  end

  # TODO: determine what is required for a survey to be publishable and implement this method.
  # def publishable?
  #   categories.any? && questions.any? && answer_options.any? && score_range_steps.any?
  # end
end
