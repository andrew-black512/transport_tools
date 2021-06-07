require_relative "timeutil.rb"

def testtime ( n )
  puts n
  puts timefromnow( (Time.now + n ).strftime("%H:%M") )
end
testtime +61
testtime +1
testtime -3
