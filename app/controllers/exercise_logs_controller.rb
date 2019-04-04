class ExerciseLogsController < ApplicationController
  before_action :set_exercise_log, only: [:show, :edit, :update, :destroy]
  layout 'no_white_container', only: [:index]

  def index
    @exercise_logs = current_user.exercise_logs.order(datetime_occurred: 'DESC' )
  end

  def show
  end

  def new
    @exercise_log = current_user.exercise_logs.new
  end

  def edit
  end

  def create
    @exercise_log = current_user.exercise_logs.new(exercise_log_params)

    respond_to do |format|
      if @exercise_log.save
        format.html { redirect_to root_url, notice: 'Log entry was successfully created.' }
        format.json { render :show, status: :created, location: @exercise_log }
      else
        format.html { render :new }
        format.json { render json: @exercise_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @exercise_log.update(exercise_log_params)
        format.html { redirect_to root_url, notice: 'Log entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @exercise_log }
      else
        format.html { render :edit }
        format.json { render json: @exercise_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @exercise_log.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Log entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_exercise_log
      @exercise_log = ExerciseLog.find(params[:id])
    end

    def exercise_log_params
      params.require(:exercise_log).permit(:user_id, :body_part_id, :datetime_occurred, :sets, :reps, :rep_length, :exercise_id, :burn_rep, :progress_note)
    end
end
