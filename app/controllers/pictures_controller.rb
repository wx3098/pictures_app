class PicturesController < ApplicationController
    before_action :set_picture, only: [:show, :edit, :update, :destroy]
    def index
      @pictures = Picture.all
    end

    def new
      if params[:back]
        @picture = Picture.new(feed_params)
      else
        @picture = Picture.new
      end
    end

    def create
      @picture = Picture.new(picture_params)
      if @picture.save
      PictureMailer.picture_mail(@picture).deliver
      redirect_to pictures_path, notice: '投稿しました！'
      else
        render :new
      end
    end

    def show
      @favorite = current_user.favorites.find_by(picture_id: @picture.id)
    end

    def edit
    end

    def update
      if @picture.update(picture_params)
        redirect_to pictures_path, notice: '編集しました!'
      else
        render :edit
      end
    end

    def destroy
      @picture.destroy
      redirect_to pictures_path, notice: '削除しました!'
    end

    private

    def set_picture
        @picture = Picture.find(params[:id])
    end

    def picture_params
        params.require(:picture).permit(:name, :email, :content, :image, :image_cache)
    end
end
