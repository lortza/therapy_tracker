# frozen_string_literal: true

class ExerciseLogsController < ApplicationController
  before_action :set_exercise_log, only: %i[show edit update destroy]
  before_action :authorize_exercise_log, only: %i[show edit update destroy]
  layout "no_white_container", only: [:index]

  def index
    logs = current_user.exercise_logs
      .at_home
      .order(occurred_at: "DESC")
      .paginate(page: params[:page], per_page: 25)

    @logs = ExerciseLogDecorator.decorate_collection(logs)
  end

  def show
    @pt_session_log = nil
  end

  def new
    @exercise_log = current_user.exercise_logs.new.decorate
  end

  def edit
  end

  def create
    @exercise_log = current_user.exercise_logs.new(exercise_log_params)

    respond_to do |format|
      if @exercise_log.save
        format.html { redirect_to exercise_log_path(@exercise_log) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @exercise_log.update(exercise_log_params)
        format.html { redirect_to exercise_log_path(@exercise_log) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @exercise_log.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
    end
  end

  private

  def authorize_exercise_log
    redirect_to root_path, alert: authorization_alert unless authorized_user?(@exercise_log)
  end

  def set_exercise_log
    @exercise_log = ExerciseLog.find(params[:id]).decorate
  end

  def exercise_log_params
    params.require(:exercise_log).permit(
      :user_id,
      :body_part_id,
      :occurred_at,
      :exercise_id,
      :sets,
      :reps,
      :rep_length,
      :per_side,
      :resistance,
      :burn_set,
      :burn_rep,
      :progress_note
    )
  end
end
