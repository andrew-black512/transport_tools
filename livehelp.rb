def helptext
  puts "Running #{__dir__}"
  #system 'git show -s --format="%ad = %B" '
  puts <<EOS

     ./livedep.rb <mode>   station:station

     <mode> is either  "t" - train or "b" bus

EOS
end

helptext
