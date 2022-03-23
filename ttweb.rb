#!/usr/bin/ruby

from=ARGV.shift
to=ARGV.shift

puts "https://traintimes.org.uk/#{from}/#{to}"
puts "https://www.realtimetrains.co.uk/search/detailed/gb-nr:#{from}/to/gb-nr:#{to}"
