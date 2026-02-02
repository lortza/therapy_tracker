# frozen_string_literal: true

class ExercisesController < ApplicationController
  before_action :set_exercise, only: %i[show edit update destroy]
  before_action :authorize_exercise, only: %i[show edit update destroy]

  def index
    @exercises = current_user.exercises.search(params[:search]).by_name
  end

  def show
    respond_to do |format|
      format.html { render json: @exercise, status: :ok }
      format.turbo_stream
    end
  end

  def new
    @exercise = current_user.exercises.new
  end

  def edit
  end

  def create
    @exercise = current_user.exercises.new(exercise_params)

    if @exercise.save
      redirect_to exercises_url
    else
      render :new
    end
  end

  def update
    if @exercise.update(exercise_params)
      redirect_to exercises_url, notice: "Exercise was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @exercise.destroy
    respond_to do |format|
      format.html { redirect_to exercises_url, notice: "Exercise was successfully destroyed." }
    end
  end

  private

  def set_exercise
    @exercise = Exercise.find(params[:id])
  end

  def authorize_exercise
    redirect_to root_path, alert: authorization_alert unless authorized_user?(@exercise)
  end

  def exercise_params
    params.require(:exercise)
      .permit(:user_id, :name, :default_sets, :default_reps, :default_rep_length, :default_resistance, :description, :default_per_side)
  end
end
