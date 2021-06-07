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
    puts timestr
    timediff = (  Time.parse( timestr) -  Time.now ).to_int
    # sign
    puts timediff
    sign = timediff < 0 ? '-' : ''
    sprintf "%1s%2dm% 0.2ds" , sign, timediff.abs / 60 , timediff.abs % 60
end
