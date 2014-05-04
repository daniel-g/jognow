class TimeEntriesController < ApplicationController
  expose(:time_entries){ TimeEntry.scoped }
  expose(:time_entry, attributes: :time_entry_params)

  respond_to :html, :json

  def index
    respond_to do |format|
      format.json{
        self.time_entries = TimeEntriesSearch.new(search_params).results
        render json: time_entries
      }
      format.html
    end
  end

  def show
  end

  def create
    time_entry.save
    respond_with time_entry, location: nil
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

  def search_params
    params.permit(:from, :to)
  end
end
