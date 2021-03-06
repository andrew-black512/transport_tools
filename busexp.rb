#!/usr/bin/ruby

# TODO: Add a loop, limited to 10 mins say

require 'json'
require 'time'
require 'httparty'
require 'pp'
require_relative "cred" # TODO: make option
require_relative 'lib/timeutil'

#-------------------------------------------------------------------------------
def stop_name( dep )
  dep["name"]
# TODO: "stop_name": "Elsie Road" might be an alternative
end
#-------------------------------------------------------------------------------
def check_response( r )
  # r is of class HTTParty.response and might be
  #  - parsed as JSON
  #  - raw HTML

  if r.body[0] != "{"
    puts "unexpected response from API:" + r.body[0,30]
    exit
  end
  if r['error']
    puts "Error : #{r['error']}"
    exit
  end
end
#-------------------------------------------------------------------------------
def getDepartures( stopnum )

  par= [
      'bus' ,
      'stop' ,
      stopnum ,
       ].join '/'
  idkey=get_key

  url = "http://transportapi.com/v3/uk/#{par}/live.json?#{idkey}"

  response = HTTParty.get(URI.parse(url))
  check_response (response)
  return response
end
def get_dep_time ( d )
  case
  when d[ 'expected_departure_time' ]
    d[ 'expected_departure_time' ]
  when d[ 'aimed_departure_time' ]
    d[ 'aimed_departure_time' ]
  else
    ''
  end
end
###     sprintf "%-5s t%-3s ",
#      d[ 'expected_departure_time' ] ,
#      d[ 'aimed_departure_time' ] [3,5]


def print_depatures (dep)
  puts stop_name( dep )
  wanted_bus = { } ## TODO: make a param
  wanted_bus = {'185'=> true, '176'=> true ,'484'=> true, '37'=>true} ## TODO: make a param
#  wanted_bus.default = true
  # puts  dep.keys.join ','
  dep["departures"].each do |key,depgroup|
    if wanted_bus [key]
      puts key    #  a line (normaly a busnumber)
      #pp depgroup #  an [array] of departures
      depgroup.each do  |d|
        dep_time = get_dep_time (d) ###["expected_departure_time"] # TODO
        wait = timefromnow( dep_time )
        printf ("    %-6s %-6s (%-5s) %-30s %-10s\n") ,
           d[ 'expected_departure_time' ] ,
           d[ 'aimed_departure_time' ] ,
           wait ,
           d['direction'] , d['operator']
      end
      puts  # blank line between groups
    end
  end
end

def get_stopname( textname) # TODO: rename
  # '490006526A'
  textname # TODO: translate as needed
end

ARGV.each do |s|
  stop = get_stopname( s )
  print_depatures ( getDepartures  stop)
end
puts "end"  #
# TODO: produce error (warning) if no valid buses found.
# (looks as though program has hung)
