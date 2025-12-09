# frozen_string_literal: true

class PtSessionLogs::ExerciseLogsController < PtSessionLogsController
  before_action :set_pt_session_log
  before_action :set_exercise_log, only: %i[show edit update destroy]
  before_action :authorize_pt_session_log, only: %i[show edit update destroy]
  before_action :authorize_exercise_log, only: %i[show edit update destroy]
  layout "no_white_container", only: [:index]

  def new
    @exercise_log = @pt_session_log.exercise_logs.new
  end

  def edit
  end

  def show
    render "exercise_logs/show"
  end

  def create
    @exercise_log = @pt_session_log.exercise_logs.new(exercise_log_params)
    @exercise_log.user_id = current_user.id

    respond_to do |format|
      if @exercise_log.save
        format.html { redirect_to pt_session_log_exercise_log_url(@pt_session_log, @exercise_log) }
        format.json { render :show, status: :created, location: @pt_session_log }
      else
        format.html { render :new }
        format.json { render json: @exercise_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @exercise_log.update(exercise_log_params)
        format.html { redirect_to pt_session_log_url(@pt_session_log) }
        format.json { render :show, status: :ok, location: @pt_session_log }
      else
        format.html { render :edit }
        format.json { render json: @exercise_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @exercise_log.destroy
    respond_to do |format|
      format.html { redirect_to pt_session_log_path(@pt_session_log), notice: "Exercise log was deleted." }
      format.json { head :no_content }
    end
  end

  private

  def authorize_exercise_log
    redirect_to root_path, alert: authorization_alert unless authorized_user?(@exercise_log)
  end

  def authorize_pt_session_log
    redirect_to root_path, alert: authorization_alert unless authorized_user?(@pt_session_log)
  end

  def set_exercise_log
    @exercise_log = ExerciseLog.find(params[:id]).decorate
  end

  def set_pt_session_log
    @pt_session_log = PtSessionLog.find(params[:pt_session_log_id])
  end

  def exercise_log_params
    params.require(:exercise_log).permit(
      :pt_session_log_id,
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
