class PicturesController < ApplicationController
    def index
      @pictures = Picture.all
    end
    
    def new
      @picture = Picture.new
    end

    def create
      Picture.new(picture_params)
      redirect_to new_picture_path
    end

    def show 
      @favorite = current_user.favorites.find_by(picture_id: @picture.id)
    end

    private

    def picture_params
        params.require(:picture).permit(:content)
    end
end
