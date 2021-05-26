require "holidays"

class Date

  def nonworkday?(region)
    #TODO gives undefined method `holiday?' 
    # see for whetehr it has changed 
    #   https://github.com/holidays/holidays#extending-rubys-date-and-time-classes
    #self.holiday?(region) || 

    self.wday == 6 || self.wday == 0  
    
  end
end

