#!/usr/bin/ruby

# TODO: Add a loop, limited to 10 mins say

require 'json'
require 'httparty'

require_relative 'printdep.rb'
require_relative "cred" # TODO: make option

#-------------------------------------------------------------------------------
def getDepartures( mode, stop_descript )
  # This is aiming to be the same for train/bus - word "stop" can include "station"
  diagnostics = false ## TODO: make configarble

  # stop_descript is FROM:<dest>
  (from_stop,tostop) = stop_descript.split ':'
  case
    #TODO maybe make .nil? the else condition
    when tostop.nil?
      extra = ''
    else
      extra = "&calling_at=#{tostop}"
  end

  puts "extra: #{extra}" if diagnostics
  par = mode == 't' ? 'train/station' : 'bus/stop'
  idkey=get_key
  # extra = '&calling_at=LBG&to_offset=PT04:00:00'

  url = "http://transportapi.com/v3/uk/#{par}/#{from_stop}/live.json?#{idkey}#{extra}"
  #puts url

  response = HTTParty.get(URI.parse(url))
  if err = response['error']
    puts "ERROR: #{err}"
    exit
  end
  #puts response.body.to_s
  trasport_data = JSON::parse(response.body)
  ## pp trasport_data

  return trasport_data
end
#-------------------------------------------------------------------------------

def get_stopname( textname) # TODO: rename
  # '490006526A'
  textname # TODO: translate as needed
end
#-------------------------------------------------------------------------------
def helptext
  puts
  puts "Running #{__dir__}"
  #system 'git show -s --format="%ad = %B" '
  puts <<EOS

     ./livedep.rb <mode>   <stationcode> .....

     where
     <stationcode> is
       station:station  or  station

     <mode> is either  "t" - train or "b" bus

     Note:
      - the API doesnt seem to send platform info for small stations

EOS
end

#-------------------------------------------------------------------------------
mode = ARGV.shift
case mode
  when /^[tb]/i
  else
    helptext
    exit
end
mode = mode.downcase

ARGV.each do |s|
  stop = get_stopname( s )
  # TODO: change stopename spelling to match printdep
  print_depatures ( getDepartures( mode, stop) )
end
puts "end"  #
# TODO: produce error (warning) if no valid buses found.
# (looks as though program has hung)
