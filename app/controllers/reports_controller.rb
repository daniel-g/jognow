class ReportsController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def time_entries
    render json: TimeEntriesSearch.new(current_user, search_params).totals
  end

  private

  def search_params
    params.permit(:from, :to)
  end
end
