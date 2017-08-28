class PuppiesController < ApplicationController
  def index
    @puppies = Puppy.all
  end

  def show
    young_puppy = Puppy.find(params[:id])
    @puppy = PuppyAgingService.new(young_puppy).process
  end

  def new
    @puppy = Puppy.new
  end

  def create
    puppy = Puppy.create(puppy_params)
    if puppy.errors.messages.empty?
      flash[:notice] = "Congrats!"
    else
      error_messages = puppy.errors.messages
      error_messages.each do |field, reason|
        flash[:alert] = "#{field} #{reason}. "
      end
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
