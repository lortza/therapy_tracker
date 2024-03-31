# frozen_string_literal: true

class SlitLogsController < ApplicationController
  before_action :set_slit_log, only: %i[edit update destroy]
  before_action :authorize_slit_log, only: %i[edit update destroy]
  layout 'no_white_container', only: [:index]

  def index
    logs = current_user.slit_logs
                        .order(occurred_at: 'DESC')
                        .paginate(page: params[:page], per_page: 25)

    @logs = SlitLogDecorator.decorate_collection(logs)
  end

  def edit
  end

  def new
    @slit_log = current_user.slit_logs.new(
      occurred_at: Time.current
    ).decorate
  end

  def create
    @slit_log = current_user.slit_logs.new(slit_log_params)

    if @slit_log.save!
      redirect_to root_url
    else
      render :new
    end
  end

  def quick_log_create
    @slit_log = current_user.slit_logs.new(occurred_at: Time.current)

    if @slit_log.save!
      redirect_to root_url
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @slit_log.update(slit_log_params)
        format.html { redirect_to root_url }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @slit_log.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'slit log was successfully destroyed.' }
    end
  end

  def report
    report_record_limit = 90
    @index_to_prompt_calling = 45
    logs = current_user.slit_logs
                        .where(occurred_at: report_record_limit.days.ago..Time.current)
                        .order(occurred_at: :asc)
                        .limit(report_record_limit)

    @logs = SlitLogDecorator.decorate_collection(logs)
  end

  private

  def set_slit_log
    @slit_log = current_user.slit_logs.find(params[:id]).decorate
  end

  def authorize_slit_log
    redirect_to root_path, alert: authorization_alert unless authorized_user?(@slit_log)
  end

  def slit_log_params
    params.require(:slit_log).permit(:user_id,
                                     :occurred_at,
                                     :started_new_bottle,
                                     :doses_remaining)
  end
end
