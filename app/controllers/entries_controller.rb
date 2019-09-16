class EntriesController < ApplicationController
  before_action :set_recruit
  before_action :require_logged_in_user


  def new
    @entry = Entry.new
  end

  def create
    @entry =  Entry.new(entry_params)
    if @entry.save!
      redirect_to @recruit
      flash[:notice] = '応募しました！'
    else
      render new_entry_path(@recruit.id)
      flash[:alert] = '応募できませんでした'
    end
  end

  def show
  end


  private
  def entry_params
    params.require(:entry).permit(:user_id, :recruit_id, :message)
  end

  def set_recruit
    @recruit = Recruit.find(params[:recruit_id])
  end
end
