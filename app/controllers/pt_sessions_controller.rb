# frozen_string_literal: true

class PtSessionsController < ApplicationController
  before_action :set_pt_session, only: %i[show edit update destroy]
  before_action :authorize_pt_session, only: %i[show edit update destroy]
  layout 'no_white_container', only: [:index]

  def index
    @logs = current_user.pt_sessions.order(datetime_occurred: 'DESC').paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def new
    @pt_session = current_user.pt_sessions.new
  end

  def edit
  end

  def create
    @pt_session = current_user.pt_sessions.new(pt_session_params)

    respond_to do |format|
      if @pt_session.save
        format.html { redirect_to root_url }
        format.json { render :show, status: :created, location: @pt_session }
      else
        format.html { render :new }
        format.json { render json: @pt_session.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @pt_session.update(pt_session_params)
        format.html { redirect_to root_url }
        format.json { render :show, status: :ok, location: @pt_session }
      else
        format.html { render :edit }
        format.json { render json: @pt_session.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pt_session.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Physical therapy session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_pt_session
    @pt_session = PtSession.find(params[:id])
  end

  def authorize_pt_session
    redirect_to root_path, alert: "Whoops! You're not authorized to view that page." unless authorized_user?(@pt_session)
  end

  def pt_session_params
    params.require(:pt_session).permit(:user_id,
                                       :body_part_id,
                                       :datetime_occurred,
                                       :exercise_notes,
                                       :homework, :duration,
                                       :questions,
                                       homework_exercise_ids: [])
  end
end
