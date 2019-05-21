# frozen_string_literal: true

class PtSessions::ExerciseLogsController < PtSessionsController
  before_action :set_pt_session
  before_action :set_exercise_log, only: %i[show edit update destroy]
  before_action :authorize_pt_session, only: %i[show edit update destroy]
  before_action :authorize_exercise_log, only: %i[show edit update destroy]
  layout 'no_white_container', only: [:index]

  def new
    @exercise_log = @pt_session.exercise_logs.new
  end

  def edit
  end

  def show
    render './exercise_logs/show'
  end

  def create # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    @exercise_log = @pt_session.exercise_logs.new(exercise_log_params)
    @exercise_log.user_id = current_user.id

    respond_to do |format|
      if @exercise_log.save
        format.html { redirect_to pt_session_exercise_log_url(@pt_session, @exercise_log) }
        format.json { render :show, status: :created, location: @pt_session }
      else
        format.html { render :new }
        format.json { render json: @exercise_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @exercise_log.update(exercise_log_params)
        format.html { redirect_to pt_session_url(@pt_session) }
        format.json { render :show, status: :ok, location: @pt_session }
      else
        format.html { render :edit }
        format.json { render json: @exercise_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @exercise_log.destroy
    respond_to do |format|
      format.html { redirect_to pt_session_path(@pt_session), notice: "#{@exercise_log.exercise_name} was deleted." }
      format.json { head :no_content }
    end
  end

  private

  def authorize_exercise_log
    redirect_to root_path, alert: authorization_alert unless authorized_user?(@exercise_log)
  end

  def authorize_pt_session
    redirect_to root_path, alert: authorization_alert unless authorized_user?(@pt_session)
  end

  def set_exercise_log
    @exercise_log = ExerciseLog.find(params[:id])
  end

  def set_pt_session
    @pt_session = PtSession.find(params[:pt_session_id])
  end

  def exercise_log_params # rubocop:disable Metrics/MethodLength
    params.require(:exercise_log).permit(:pt_session_id,
                                         :user_id,
                                         :body_part_id,
                                         :datetime_occurred,
                                         :exercise_id,
                                         :sets,
                                         :reps,
                                         :rep_length,
                                         :per_side,
                                         :resistance,
                                         :burn_set,
                                         :burn_rep,
                                         :progress_note)
  end
end
