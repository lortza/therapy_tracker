# frozen_string_literal: true

class PainLogsController < ApplicationController
  before_action :set_pain_log, only: %i[show edit update destroy]
  before_action :authorize_pain_log, only: %i[show edit update destroy]
  layout 'no_white_container', only: [:index]

  def index
    @logs = current_user.pain_logs
                        .search(body_part_id: search_params[:body_part_id],
                                pain_id: search_params[:pain_id],
                                search_terms: search_params[:search])
                        .order(datetime_occurred: 'DESC')
                        .paginate(page: params[:page], per_page: 25)
  end

  def show
  end

  def new
    @pain_log = current_user.pain_logs.new
  end

  def edit
  end

  def create
    @pain_log = current_user.pain_logs.new(pain_log_params)

    if @pain_log.save
      redirect_to root_url
    else
      render :new
    end
  end

  def create_from_easy_button
    easy_button = current_user.easy_buttons.find(params[:easy_button])
    attributes = easy_button.attributes
                            .except('id','user_id','name', 'created_at', 'updated_at')
                            .merge(datetime_occurred: Time.current)

    @pain_log = current_user.pain_logs.new(attributes)

    if @pain_log.save
      redirect_to pain_logs_url, notice: "#{easy_button.name} was logged."
      return
    else
      redirect_to pain_logs_url, alert: "#{easy_button.name} was not logged."
      return
    end
  end

  def update
    respond_to do |format|
      if @pain_log.update(pain_log_params)
        format.html { redirect_to root_url }
        format.json { render :show, status: :ok, location: @pain_log }
      else
        format.html { render :edit }
        format.json { render json: @pain_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pain_log.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Pain log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_pain_log
    @pain_log = PainLog.find(params[:id])
  end

  def authorize_pain_log
    redirect_to root_path, alert: authorization_alert unless authorized_user?(@pain_log)
  end

  def search_params
    params.permit(:search, :pain_id, :body_part_id)
  end

  def pain_log_params
    params.require(:pain_log).permit(:user_id,
                                     :body_part_id,
                                     :pain_id,
                                     :datetime_occurred,
                                     :pain_level,
                                     :pain_description,
                                     :trigger)
  end
end
