require_relative "timeutil.rb"

def testtime ( n )
  puts
  puts n
  puts timefromnow( (Time.now + n ).strftime("%H:%M:%S") )
end
testtime +61
testtime +1
testtime -3
testtime 0
