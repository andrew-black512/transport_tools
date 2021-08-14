#!/usr/bin/ruby

# TODO: Add a loop, limited to 10 mins say

require 'json'
require 'time'
require 'httparty'
require 'pp'
require_relative 'lib/timeutil'

#-------------------------------------------------------------------------------
def stop_name( dep )
  dep["name"]
# TODO: "stop_name": "Elsie Road" might be an alternative
end
#-------------------------------------------------------------------------------
def get_dep_time ( d )   # TODO is this used
  case
  when d[ 'expected_departure_time' ]
    d[ 'expected_departure_time' ]
  when d[ 'aimed_departure_time' ]
    d[ 'aimed_departure_time' ]
  else
    ''
  end
end
#-------------------------------------------------------------------------------
def get_destination ( d )
  case
  when d[ 'destination_name' ]
    d[ 'destination_name' ]
  when d[ 'direction' ]
    d[ 'direction' ]
  else
    ''
  end
end
#-------------------------------------------------------------------------------

def print_depatures (dep)
  puts stop_name( dep )
  wanted_bus = {'484'=> true } ## TODO: make a param
  wanted_bus.default = true
  # puts  dep.keys.join ','
  dep["departures"].each do |key,depgroup|
    if wanted_bus [key]
      puts key    #  a line (normaly a busnumber)
      #pp depgroup #  an [array] of departures

      # Note - platform is NULL for EDW  and comes out blank
      depgroup.each do  |d|
        dep_time = get_dep_time (d) ###["expected_departure_time"] # TODO
        wait = timefromnow( dep_time )
        printf ("    %-6s %-6s %-10s %-3s (%-5s) %-20s %-10s\n") ,
           d[ 'expected_departure_time' ] ,
           d[ 'aimed_departure_time' ] ,
           d['status'] ,
           d['platform'] ,
           wait , get_destination(d) , d['operator']
      end
      puts  # blank line between groups
    end
  end
end

def get_stopname( textname) # TODO: rename
  # '490006526A'
  textname # TODO: translate as needed
end
