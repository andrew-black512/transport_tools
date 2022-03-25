#!/usr/bin/ruby
# TODO: consider selecting site(NRE, rtt ...) and going to browser.

puts
puts "Right click on URL to browse"
ARGV.each do |statpair|
  (from,to)=statpair.split ':'
  puts
  puts "https://traintimes.org.uk/#{from}/#{to}"
  puts "https://www.realtimetrains.co.uk/search/detailed/gb-nr:#{from}/to/gb-nr:#{to}"
  puts "https://ojp.nationalrail.co.uk/service/ldbboard/dep/#{from}/#{to}/To"
end
puts
