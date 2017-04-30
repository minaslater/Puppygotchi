class PuppyController < ApplicationController
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
    Puppy.create(puppy_params)
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
