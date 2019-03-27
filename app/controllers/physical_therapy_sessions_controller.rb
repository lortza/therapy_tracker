class PhysicalTherapySessionsController < ApplicationController
  before_action :set_physical_therapy_session, only: [:show, :edit, :update, :destroy]

  def index
    @physical_therapy_sessions = current_user.physical_therapy_sessions.order(datetime_occurred: 'DESC' )
  end

  def show
  end

  def new
    @physical_therapy_session = current_user.physical_therapy_sessions.new
  end

  def edit
  end

  def create
    @physical_therapy_session = current_user.physical_therapy_sessions.new(physical_therapy_session_params)

    respond_to do |format|
      if @physical_therapy_session.save
        format.html { redirect_to root_url, notice: 'Physical therapy session was successfully created.' }
        format.json { render :show, status: :created, location: @physical_therapy_session }
      else
        format.html { render :new }
        format.json { render json: @physical_therapy_session.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @physical_therapy_session.update(physical_therapy_session_params)
        format.html { redirect_to root_url, notice: 'Physical therapy session was successfully updated.' }
        format.json { render :show, status: :ok, location: @physical_therapy_session }
      else
        format.html { render :edit }
        format.json { render json: @physical_therapy_session.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @physical_therapy_session.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Physical therapy session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_physical_therapy_session
      @physical_therapy_session = PhysicalTherapySession.find(params[:id])
    end

    def physical_therapy_session_params
      params.require(:physical_therapy_session).permit(:user_id, :datetime_occurred, :target_body_part, :exercise_notes, :homework, :duration)
    end
end
