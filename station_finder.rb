#!/usr/bin/ruby
require 'pry'

require 'pp'
require 'csv'


def find_station ( word )

  CSV.foreach(  '/home/andrew/dev/transport/station_codes.csv', headers:true ) do |row|
	  station = row[0]
		if station.match word
			#binding.pry
			puts row
		end
  end
end

wanted = ARGV.shift
wanted_re = Regexp.new wanted

find_station wanted_re
