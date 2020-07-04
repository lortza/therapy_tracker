# frozen_string_literal: true

class PainLogsController < ApplicationController
  before_action :set_pain_log, only: %i[show edit update destroy]
  before_action :authorize_pain_log, only: %i[show edit update destroy]
  layout 'no_white_container', only: [:index]

  def index
    search_terms = search_params[:search]
    pain_id = search_params[:pain_name]
    body_part_id = search_params[:body_part_name]

    @logs = current_user.pain_logs
                        .search(body_part_id: body_part_id, pain_id: pain_id, search_terms: search_terms)
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

  def create # rubocop:disable Metrics/AbcSize
    @pain_log = current_user.pain_logs.new(pain_log_params)

    respond_to do |format|
      if @pain_log.save
        format.html { redirect_to root_url }
        format.json { render :show, status: :created, location: @pain_log }
      else
        format.html { render :new }
        format.json { render json: @pain_log.errors, status: :unprocessable_entity }
      end
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
    params.permit(:search, :pain_name, :body_part_name)
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
