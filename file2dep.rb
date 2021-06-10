#!/usr/bin/ruby

require 'json'


ARGV.each do |f|
   puts "file #{f}"
   data = File.read f
   trasport_data = JSON::parse( data )
   pp trasport_data


end
