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
    @puppy = Puppy.find(params[:id])
    @puppy.update(update_params)
    needs
    redirect_to action: "show"
  end

  private

  def puppy_params
    params.require(:puppy).permit(:name)
  end

  def update_params
    params.permit(:stomach, :bladder, :bowel, :bored)
  end

  def needs
    flash[:alert] = "#{@puppy.name} is hungry!" if @puppy.stomach <= 3
    flash[:alert] = "#{@puppy.name} needs to go for a walk!" if @puppy.bladder >= 10 || @puppy.bowel >=10
    flash[:notice] = "Play with #{@puppy.name}!" if @puppy.bored == true
  end
end
