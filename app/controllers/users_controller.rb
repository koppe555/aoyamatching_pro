class UsersController < ApplicationController

  before_action :current_user, only: [:show, :edit]
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @recruits = Recruit.where(user_id: @user.id).order(created_at: "DESC")
    @entries = Entry.where(user_id: @user.id)
    @user_entry_id = []
    @entries.each_with_index do |recruit, i|
      @user_entry_id[i] = recruit.recruit_id
    end
    @entries = Recruit.where(id: @user_entry_id)
  end

  def edit

  end

  def update
    @user.update!(user_params)
    redirect_to user_path(@user.id)
  end



  private

  def user_params
    params.require(:user).permit(:name, :mail, :password, :introduction, :password_confirmation, :campus, :faculty, :grade)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end


end