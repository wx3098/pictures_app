class PicturesController < ApplicationController
    before_action :set_picture, only: [:show, :edit, :update, :destroy]
    def index
      @pictures = Picture.all
    end

    def new
        @picture = Picture.new
    end

    def create
        @picture = current_user.pictures.build(picture_params)
       if params[:back]
        render :new
       else
      if @picture.save
    #   PictureMailer.picture_mail(@picture).deliver
      redirect_to pictures_path, notice: '投稿しました！'
       else
        render :new
       end
      end
    end

    def show
      @picture = Picture.find(params[:id])
      @favorite = current_user.favorites.find_by(picture_id: @picture.id)
    end

    def edit
      @picture = Picture.find(params[:id])
    end

    def update
      @picture = Picture.find(params[:id])
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

    def confirm
        @picture = Picture.new(picture_params)
        @picture.user_id = current_user.id
        render :new if @picture.invalid?
      end

    private

    def set_picture
        @picture = Picture.find(params[:id])
    end

    def picture_params
        params.require(:picture).permit(:name, :email, :content, :image, :image_cache)
    end
end
