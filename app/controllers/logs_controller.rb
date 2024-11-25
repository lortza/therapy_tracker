# frozen_string_literal: true

class LogsController < ApplicationController
  layout "no_white_container"

  def index
    @logs = Log.all(current_user).paginate(page: params[:page], per_page: 25)
  end
end
