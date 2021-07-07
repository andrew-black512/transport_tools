#!/usr/bin/ruby

require 'json'
require_relative 'printdep'


ARGV.each do |f|
   puts "file #{f}"
   data = File.read f
   trasport_data = JSON.parse( data )
   print_depatures trasport_data



end
