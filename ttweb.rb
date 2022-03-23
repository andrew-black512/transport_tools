#!/usr/bin/ruby
# TODO: consider selecting type

ARGV.each do |statpair|
  (from,to)=statpair.split ':'
  puts
  puts "https://traintimes.org.uk/#{from}/#{to}"
  puts "https://www.realtimetrains.co.uk/search/detailed/gb-nr:#{from}/to/gb-nr:#{to}"
end
puts
