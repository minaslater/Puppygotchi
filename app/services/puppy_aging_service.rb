class PuppyAgingService
  def initialize(puppy)
    @puppy = puppy
  end

  def process
    time_elapsed = change_time
    update_puppy(time_elapsed)
    @puppy
  end

  private

  def change_time
    last_updated = @puppy.updated_at
    current_time_in_utc = Time.now.getutc
    time_difference_in_seconds = current_time_in_utc - last_updated
    time_difference_in_hours = time_difference_in_seconds / 3600
    time_difference_in_hours.round
  end

  def update_puppy(hours)
    every_three_hours = hours / 3
    if hours <= 0
      @puppy
    else
      every_three_hours.times do
        @puppy.update(stomach: @puppy.stomach - 1, bladder: @puppy.bladder + 1, bowel: @puppy.bowel + 1)
      end
      if hours >= 5
        @puppy.update(bored: true)
      end
      @puppy
    end
  end
end
