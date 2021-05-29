require 'time'
def addmins(timestr, mins)
    time = Time.parse( timestr) + mins*60
    time.strftime("%H:%M")
end

#----- -7 timestr
#pp addmins "11:05",3
#pp addmins "11:05", -7
#pp addmins "23:59",3
