#!/usr/bin/ruby

#"name": "Elsie Road (Stop A)",
# notes/bus_example-10-  "stop_name": "Elsie Road",

require 'json'
require 'time'
require 'httparty'
require 'pp'

#-------------------------------------------------------------------------------
def stop_name( dep )
  dep["name"]
# # TODO:  also try  "stop_name": "Elsie Road",
end
#-------------------------------------------------------------------------------
def getDepartures( stopnum )

  par= [
  	  'bus' ,
      'stop' ,
      stopnum ,
       ].join '/'
  idkey="api_key=e007c65598b617695cdec19c8349656f&app_id=71b00a99"

  url = "http://transportapi.com/v3/uk/#{par}/live.json?#{idkey}"

  #puts url
  response = HTTParty.get(URI.parse(url))
  #puts response.body.to_s

  traindata = JSON::parse(response.body)
  ## pp traindata

  return traindata
end

def print_depatures (dep)
  puts stop_name( dep )
  wanted_bus = {'484'=> true } ## TODO: make a parm
  wanted_bus.default = true
  # puts  dep.keys.join ','
  dep["departures"].each do |key,depgroup|
    if wanted_bus [key]
      puts key # busno
      #puts depgroup.class
      #puts depgroup.first
      depgroup.each do  |d|
        puts '    ' + d["expected_departure_time"]
      end
    end
    puts
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
