require 'pp'
require 'csv'

prefix = Hash.new (0)

CSV.foreach(  '/home/andrew/dev/transport/station_codes.csv' ) do |row|
	station = row[0]
	station.gsub!(/\s* \( .* \) /x , '' ) 

	station_words = station.split(" ")
	if station_words.count > 1
		#puts station
    z= [0,station_words.count-1]
	  z.each do |n|

      prefix [ station_words[n] ] = prefix [ station_words[n] ] + 1
		end
	end
end
#puts prefix
prefix.sort_by {  |prefix,count| count } .reverse .each do |pair|
	(prefixname,count) = pair
	if  count > 1
	  printf "%-20s %d\n", prefixname, count
   end
end
