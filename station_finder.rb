#!/usr/bin/ruby

require 'pp'
require 'csv'

def datafilename (suffixname )
	File.join __dir__, suffixname
end
def find_station ( word )
    datafile = datafilename 'data/station_codes.csv'
	  CSV.foreach(  datafile, headers:true ) do |row|
	  station = row[0]
		crs_code = row[1]
		if station.match(word) or crs_code.match(word)
			puts row
		end
  end
end

wanted = ARGV.shift
wanted_re = Regexp.new wanted

find_station wanted_re
