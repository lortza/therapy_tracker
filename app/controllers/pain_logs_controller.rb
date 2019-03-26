class PainLogsController < ApplicationController
  before_action :set_pain_log, only: [:show, :edit, :update, :destroy]

  def index
    @pain_logs = current_user.pain_logs.order(datetime_occurred: 'DESC' )
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

    respond_to do |format|
      if @pain_log.save
        format.html { redirect_to pain_logs_url, notice: 'Pain log was successfully created.' }
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
        format.html { redirect_to pain_logs_url, notice: 'Pain log was successfully updated.' }
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
      format.html { redirect_to pain_logs_url, notice: 'Pain log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_pain_log
      @pain_log = PainLog.find(params[:id])
    end

    def pain_log_params
      params.require(:pain_log).permit(:user_id, :datetime_occurred, :target_body_part, :pain_level, :pain_description, :trigger)
    end
end
