# frozen_string_literal: true

class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:show, :edit, :update, :destroy]
  before_action :authorize_exercise, only: [:show, :edit, :update, :destroy]

  def index
    @exercises = current_user.exercises.order(:name)
  end

  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @exercise, status: :ok }
    end
  end

  def new
    @exercise = current_user.exercises.new
  end

  def edit
  end

  def create
    @exercise = current_user.exercises.new(exercise_params)

    respond_to do |format|
      if @exercise.save
        format.html { redirect_to exercises_url, notice: 'Exercise was successfully created.' }
        format.json { render :show, status: :created, location: @exercise }
      else
        format.html { render :new }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @exercise.update(exercise_params)
        format.html { redirect_to exercises_url, notice: 'Exercise was successfully updated.' }
        format.json { render :show, status: :ok, location: @exercise }
      else
        format.html { render :edit }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @exercise.destroy
    respond_to do |format|
      format.html { redirect_to exercises_url, notice: 'Exercise was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_exercise
      @exercise = Exercise.find(params[:id])
    end

    def exercise_params
      params.require(:exercise).permit(:user_id, :name, :default_sets, :default_reps, :default_rep_length, :default_resistance, :description, :default_per_side)
    end

    def authorize_exercise
      redirect_to root_path, alert: "Whoops! You're not authorized to view that page." if @exercise.user_id != current_user.id
    end
end
