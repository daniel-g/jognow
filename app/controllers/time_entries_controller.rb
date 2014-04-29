class TimeEntriesController < ApplicationController
  expose(:time_entries){ TimeEntry.scoped }
  expose(:time_entry, attributes: :time_entry_params)

  respond_to :html, :json

  def index
    respond_with time_entries
  end

  def show
  end

  def create
    time_entry.save
    respond_with time_entry
  end

  private

  def time_entry_params
    unless params[:time_entry][:date].present?
      params[:time_entry][:date] = Date.today
    end
    params.require(:time_entry).permit(
      :date, :time, :distance
    )
  end
end
