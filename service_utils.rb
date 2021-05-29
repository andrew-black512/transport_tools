require_relative "transportapi"
require_relative 'lib/timeutil'

# returns departure (if appropriate) or arrival time for a stop
def get_time( stop)
	stop['aimed_departure_time'] ?
		stop['aimed_departure_time'] :
		stop['aimed_arrival_time'] + "a"
end

# TODO - get this from a config file / command option
@station_platform = {
    'LBG' => 1,
		'PUR' => 1, # useful for CAT/TAT trains
    'ECR' => 1,
    'DMK' => 1,
    'SUO' => 1,
    'VIC' => 1,
    'BTN' => 1,
    'EPH' => 1,   # elephant

}
# TODO  station_walk_time is not used
@station_walk_time = {
    'EDW' => 10,
    'PMR' => 25,
    'DMK' => 25,
}

def get_platform( stop)
    if @station_platform [ stop['station_code'] ]
       '-' + ( stop['platform'] || '?' )
    else
       ''
    end
end
def extract_times( stops )
      stops.map{|st|
             st['station_code'] + "-" + get_time(st)

      }.join(' ')
end

$format = '%-9s'  # TODO - make 6 when no platform
def extract_times_col_head(  wanted, format )
    printf $format, 'Toc' ;
    printf $format, 'from' ;

    wanted.each do |wanted_station_code|
        printf $format, ' '+wanted_station_code
    end
    puts ''
end
def print_start_dest(stops)
	  #could be done in colour (terminal or html)
    printf " ( %s -> %s)",
    	stops.first[ "station_code"].downcase ,
	    stops.last[ "station_code"].downcase
end
def print_leave_time( station, timestr )
	  leave_time = addmins( timestr,  - @station_walk_time[station] )
    printf $format, leave_time
end
#----------------------------------------------------------
def get_note( stops )
	## pp stops
	note = ''
	stops.each do |st|
		case st["station_code"]
		when	'PUO'
      note = ' TAT?'
		end
	end
	return note
	#####exit
end
#----------------------------------------------------------
def extract_times_col( stops, wanted, format )
    stophash = {}       # hask of stops for this train
    stops.each do |st|
    	#pp st
    	plat= get_platform(st)
    	stophash [st["station_code"]] = get_time( st) + plat
    end
		note = get_note stops
		if format == 'k'  # keyed format
			$format= '%-12s' # # TODO: bodge?
			#pp wanted.first
			print_leave_time( wanted.first, stophash[wanted.first] )
			wanted.each do |want_station|
    	  stoptime = stophash [ want_station ]
				## TODO: what if not stopping. nothing or EDW:-
				## then change format
        printf $format, stoptime ? want_station+' '+stoptime : "  "
      end
			print_start_dest stops
		else
      printf $format,  stops.first["station_code"]
      wanted.each do |want_station|
    	  stoptime = stophash [ want_station ]
        printf $format, stoptime ? stoptime : "  -"
      end
    if format == 'd'
        printf $format,  stops.last["station_code"] + note
    else # 'e'
			  # lists all stops e=excruciating ...
        printf "  %s", join_element( stops, "station_code",  '-')
    end
	end

    puts ''  # Final newline
end

# TODO: unused
def get_start_stn( stops )
   stops.first[ "station_code"]
end
def get_dest_stn( stops )
   stops.last[ "station_code"]
end

def print_departure_details( departures, datetoget, wanted_stations, format)
    transport_api = TransportAPI.new

    extract_times_col_head(  wanted_stations, format )

    departures.each do |dep|
        resp=transport_api.service  dep['train_uid'] , datetoget
        ###pp resp if 1 ;#TODO   make config
        printf $format, resp["toc"]["atoc_code"]

        extract_times_col( resp["stops"], wanted_stations, format )


    end
end

# returns the join of selected element in Hash - in this case "station_code"
def join_element( hash, element, join_with )
	hash.map { |t| t[element] }. join (join_with)
end
