#!/usr/bin/ruby

#"name": "Elsie Road (Stop A)",
# notes/bus_example-10-  "stop_name": "Elsie Road",

require 'json'
require 'time'
require 'optparse'
require 'optparse/date'
require 'optparse/time'
require 'httparty'
require 'pp'

require_relative 'holiday_add'
require_relative 'service_utils'
require_relative 'journey'
#-------------------------------------------------------------------------------
class Array
    def reverseif( condition )
      condition ?
       self.reverse :
       self
    end
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

  return traindata["departures"]
end

def print_depatures (dep)
  wanted_bus = {'484'=> true } ## TODO: make a parm
  # puts  dep.keys.join ','
  dep.each do |key,depgroup|
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

def get_stopname( textname)
  # '490006526A'
  textname # TODO: translate as needed
end

ARGV.each do |s|
  stop = get_stopname( s )
  puts stop
  print_depatures ( getDepartures  stop)
end
