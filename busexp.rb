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
def getDepartures( stopnum )

  par= [
  	  'bus' ,
      'stop' ,
      stopnum ,
       ].join '/'
  idkey=get_key

  url = "http://transportapi.com/v3/uk/#{par}/live.json?#{idkey}"
  #puts url

  response = HTTParty.get(URI.parse(url))
  #puts response.body.to_s
  trasport_data = JSON::parse(response.body)
  ## pp trasport_data

  return trasport_data
end

def print_depatures (dep)
  puts stop_name( dep )
  wanted_bus = {'484'=> true } ## TODO: make a param
  wanted_bus.default = true
  # puts  dep.keys.join ','
  dep["departures"].each do |key,depgroup|
    if wanted_bus [key]
      puts key    #  a line (normaly a busnumber)
      #pp depgroup #  an [array] of departures
      depgroup.each do  |d|
        dep_time = d["expected_departure_time"] # TODO
        wait = timefromnow( dep_time )
        printf ("    %-6s (%-7s) %-30s \n") ,
           dep_time, wait , d['direction']
      end
    end
    puts  # blank line between groups
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
