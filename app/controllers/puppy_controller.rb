class PuppyController < ApplicationController
  def index
    render plain: "Welcome to Puppygotchi"
  end

  def show
    render plain: "You've adopted a puppy!"
  end
end
