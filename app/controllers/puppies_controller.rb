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
    if @current_user
      puppy = @current_user.puppies.new(puppy_params)
      if puppy.save
        flash[:notice] = "Congrats!"
        redirect_to action: "show", id: puppy.id
      else
        flash[:alert] = puppy.errors.full_messages.to_sentence
        redirect_to action: "new"
      end
    else
      flash[:alert] = "Please log in"
      redirect_to root_path
    end
  end

  def update
    @puppy = Puppy.find(params[:id])
    return unless validate_owner
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

    def validate_owner
      if @current_user == @puppy.user
        true
      else
        flash[:alert] = "Action not permitted"
        redirect_back(fallback_location: root_path)
        false
      end
    end
    
    def needs
      flash[:alert] = "#{@puppy.name} is hungry!" if @puppy.stomach <= 3
      flash[:alert] = "#{@puppy.name} needs to go for a walk!" if @puppy.bladder >= 10 || @puppy.bowel >=10
      flash[:notice] = "Play with #{@puppy.name}!" if @puppy.bored == true
    end
end
