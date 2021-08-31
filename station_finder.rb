#!/usr/bin/ruby
require 'pry'

require 'pp'
require 'csv'


def find_station ( word )
CSV.foreach(  '/home/andrew/dev/transport/station_codes.csv' ) do |row|
	station = row[0]
	#binding.pry
	if station.match word
		binding.pry
		puts row
	end
	exit

end
end

wanted = 'Lond' # ARGV.shift
wanted_re = Regexp.new wanted

find_station wanted_re
