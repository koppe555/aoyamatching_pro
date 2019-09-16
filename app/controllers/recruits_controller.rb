class RecruitsController < ApplicationController
  require 'mini_magick'
  require 'securerandom'

  before_action :set_recruit, only: [:show]
  before_action :set_entries, only: [:show]
  before_action :require_logged_in_user, except: [:index, :show]

  def new
    @recruit = Recruit.new
  end

  def create
    @recruit = Recruit.new(recruit_params)
    build(@recruit.title)
    if @recruit.save
      redirect_to @recruit
      flash[:notice] = '募集が作成されました'
    else
      render new_recruit_path
    end
  end

  def show
  end


  def index
    @recruits = Recruit.all.order(created_at: "DESC")
  end



  private

  def set_recruit
    @recruit = Recruit.find_by(id: params[:id])
  end

  def set_entries
    @entries = Entry.where(recruit_id: params[:id])
  end

  def recruit_params
    params.require(:recruit).permit(:title, :contents).merge(user_id: current_user.id)
  end

  # ここから下は画像の生成

  BASE_IMAGE_PATH = './app/assets/images/base_image.png'
  GRAVITY = 'center'.freeze
  TEXT_POSITION = '0, 0'.freeze
  COLOR = 'white'
  FONT = './app/assets/fonts/font_1_ant-kaku.ttf'.freeze
  FONT_SIZE = 260
  INDENTION_COUNT  = 11
  ROW_LIMIT  = 8


  def build(title)
    title = prepare_title(title)
    @image = MiniMagick::Image.open(BASE_IMAGE_PATH)
    configration(title)
  end


  def configration(title)
    @image.combine_options do |i|
      i.font FONT
      i.fill COLOR
      i.gravity GRAVITY
      i.pointsize FONT_SIZE
      i.draw "text #{TEXT_POSITION} '#{title}'"
    end
    dest_path = "#{SecureRandom.hex}.png"
# 重複チェックなどが必要ならばここで
    @image.write Rails.public_path.join(dest_path)
    @recruit.image_url = dest_path
  end



  def prepare_title(title)
    title.scan(/.{1,#{INDENTION_COUNT}}/)[0...ROW_LIMIT].join("\n")
  end



end
