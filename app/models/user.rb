# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                         :bigint           not null, primary key
#  admin                      :boolean          default(FALSE), not null
#  email                      :string           default(""), not null
#  enable_pt_session_tracking :boolean          default(FALSE)
#  enable_slit_tracking       :boolean          default(FALSE)
#  encrypted_password         :string           default(""), not null
#  first_name                 :string           default(""), not null
#  last_name                  :string           default(""), not null
#  remember_created_at        :datetime
#  reset_password_sent_at     :datetime
#  reset_password_token       :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :pain_log_quick_form_values, dependent: :destroy
  has_many :body_parts, dependent: :destroy
  has_many :exercises, dependent: :destroy
  has_many :exercise_logs, dependent: :destroy
  has_many :pains, dependent: :destroy
  has_many :pain_logs, dependent: :destroy
  has_many :pt_session_logs, dependent: :destroy
  has_many :slit_logs, dependent: :destroy
  has_one :slit_configuration, dependent: :destroy
  accepts_nested_attributes_for :slit_configuration

  scope :with_slit_enabled, -> { where(enable_slit_tracking: true) }

  def full_name
    [first_name.presence, last_name.presence].compact.join(" ")
  end

  def name_or_email
    full_name.presence || email
  end
end
