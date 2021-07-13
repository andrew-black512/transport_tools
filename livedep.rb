#!/usr/bin/ruby

# TODO: Add a loop, limited to 10 mins say

require 'json'
require 'httparty'

require_relative 'printdep.rb'
require_relative "cred" # TODO: make option

#-------------------------------------------------------------------------------
def getDepartures( stopnum )

  par= [
  	  # 'bus/stop' ,    #TODO parame train v bus
      'train/station' ,
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
#-------------------------------------------------------------------------------


def get_stopname( textname) # TODO: rename
  # '490006526A'
  textname # TODO: translate as needed
end
#-------------------------------------------------------------------------------

mode = ARGV.shift
ARGV.each do |s|
  stop = get_stopname( s )
  print_depatures ( getDepartures  stop)
end
puts "end"  #
# TODO: produce error (warning) if no valid buses found.
# (looks as though program has hung)
