class PuppiesController < ApplicationController
  def index
    @puppies = Puppy.all
  end

  def show
    @puppy = Puppy.find(params[:id])
  end

  def new
    @puppy = Puppy.new
  end

  def create
    if Puppy.create(puppy_params)
      flash[:notice] = "Congrats!"
    else
      flash[:alert] = "Oh no!"
    end
    redirect_to action: "index"
  end

  def update
    puppy_to_update = Puppy.find(params[:id])
    puppy_to_update.update(puppy_params)
  end

  private

  def puppy_params
    params.require(:puppy).permit(:name, :belly, :bladder, :bowel, :bored)
  end
end
