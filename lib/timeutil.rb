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
    timediff = (  Time.parse( timestr) -  Time.now )
    #puts timediff
    sprintf "%0.1f m" ,  timediff / 60
end
