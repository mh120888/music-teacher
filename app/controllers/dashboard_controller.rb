class DashboardController < ApplicationController
  def index
  end

  def lesson
    render 'dashboard/lesson/page', layout: false
  end
end