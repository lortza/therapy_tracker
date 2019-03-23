# frozen_string_literal: true

# The Admin Controller's main purpose is to set a namespace for any user or other
# app-level management that needs to happen.

class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
end
