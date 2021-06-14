require_relative "timeutil.rb"

def testtime ( n )
  puts
  puts Time.now.strftime("%H:%M:%S")
  ftime = (Time.now + n ).strftime("%H:%M")
  puts ftime
  puts timefromnow( ftime )
end
testtime +61
testtime +1
testtime -3
testtime 0
