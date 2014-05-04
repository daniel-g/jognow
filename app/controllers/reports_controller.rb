class ReportsController < ApplicationController
  def index
  end

  def time_entries
    render json: TimeEntriesSearch.new(search_params).totals
  end

  private

  def search_params
    params.permit(:from, :to)
  end
end
