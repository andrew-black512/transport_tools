require 'time'
def addmins(timestr, mins)
    time = Time.parse( timestr) + mins*60
    time.strftime("%H:%M")
end
def timediff(timestr, timestr_b)
    timediff = Time.parse( timestr) -  Time.parse( timestr_b)
    (timediff / 60 ).to_int
end
def timefromnow(timestr)
    timediff = (  Time.parse( timestr) -  Time.now ).to_int
    sprintf "%2dm% 0.2ds" , timediff / 60 , timediff % 60
end

#puts timefromnow( '13:55')
