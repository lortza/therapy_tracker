# frozen_string_literal: true

class PtSessionLogsController < ApplicationController
  before_action :set_pt_session_log, only: %i[show edit update destroy]
  before_action :authorize_pt_session_log, only: %i[show edit update destroy]
  layout 'no_white_container', only: [:index]

  def index
    @logs = current_user.pt_session_logs.order(datetime_occurred: 'DESC').paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def new
    @pt_session_log = current_user.pt_session_logs.new
  end

  def edit
  end

  def create # rubocop:disable Metrics/AbcSize
    @pt_session_log = current_user.pt_session_logs.new(pt_session_log_params)

    respond_to do |format|
      if @pt_session_log.save
        format.html { redirect_to root_url }
        format.json { render :show, status: :created, location: @pt_session_log }
      else
        format.html { render :new }
        format.json { render json: @pt_session_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @pt_session_log.update(pt_session_log_params)
        format.html { redirect_to root_url }
        format.json { render :show, status: :ok, location: @pt_session_log }
      else
        format.html { render :edit }
        format.json { render json: @pt_session_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pt_session_log.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Physical therapy session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_pt_session_log
    @pt_session_log = PtSessionLog.find(params[:id])
  end

  def authorize_pt_session_log
    redirect_to root_path, alert: authorization_alert unless authorized_user?(@pt_session_log)
  end

  def pt_session_log_params
    params.require(:pt_session_log).permit(:user_id,
                                       :body_part_id,
                                       :datetime_occurred,
                                       :exercise_notes,
                                       :homework, :duration,
                                       :questions,
                                       homework_exercise_ids: [])
  end
end
