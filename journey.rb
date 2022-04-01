class Journey
  attr :stat_list    # array of 2 stations
  attr :display_stations # array of stations to print
  def initialize( stat_list )
     @stat_list = stat_list.map { |s| s.upcase }
  end
  def route_stations
    special_stations = @stat_list .grep( /[+-]/ ).map{ |t| t.delete('+-')  }
    case special_stations.count
      when 0
        route = [ @stat_list.first, @stat_list.last ]
      when 1
        route = [ @stat_list.first, special_stations.first ]
      when 2
        route = [ special_stations.first, special_stations.last ]
    end
    route   # array of 2 stations
  end

  def display_stations
     #TODO remove - ones from the list.
     @stat_list.map{ |t| t.delete('+-')  }
  end

  def printinfo
     puts ''
     puts @route
     puts "Route_stations: " + self.route_stations.join(' ')
     puts "Display_stations: " + self.display_stations.join(' ')
  end



end
