class PuppyController < ApplicationController
  def index
    render plain: "Welcome to Puppygotchi"
  end

  def show
    render plain: "Here is your puppy!"
  end

  def new
    render plain: "What would you like to name your new friend?"
  end

  def create
    puppy = Puppy.create(puppy_params)
    render plain: "Congrats! You just adopted #{puppy.name}"
  end

  def update
  end

  private

  def puppy_params
    params.require(:puppy).permit(:name)
  end
end
