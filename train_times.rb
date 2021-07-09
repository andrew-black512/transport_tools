#!/usr/bin/ruby

require 'json'
require 'time'
require 'optparse'
require 'optparse/date'
require 'optparse/time'
require 'httparty'
require 'pp'

require_relative 'holiday_add'
require_relative 'service_utils'
require_relative 'journey'
#-------------------------------------------------------------------------------
class Array
    def reverseif( condition )
      condition ?
       self.reverse :
       self
    end
end


#-------------------------------------------------------------------------------
def getDepartures( par_from, par_to, day ,time )

  par= [
      par_from ,
      day.strftime("%Y-%m-%d") ,
      time.strftime("%H:%M") ,
       ].join '/'
  par2="calling_at=#{par_to}"
  limit="" # "limit=1&"
  idkey="api_key=e007c65598b617695cdec19c8349656f&app_id=71b00a99"
  trainlist = []

  url = "http://transportapi.com/v3/uk/train/station/#{par}/timetable.json?#{limit}#{idkey}&#{par2}"

  #puts url
  response = HTTParty.get(URI.parse(url))
  #puts response.body.to_s

  traindata = JSON::parse(response.body)
  #puts traindata

  return traindata["departures"]["all"]
end

#---------------------------------------------------------------------------
def getDeptOneDay( day, options )
  puts day.strftime("%a %d %b" )
  options[:journeylist].each do |jour|
    commandstatpair = jour.route_stations
    statpair = commandstatpair.reverseif(options[:reverse])
    printf "  %s\n", statpair.join(">")
    from_st,to_st = statpair
    departures = getDepartures(from_st, to_st, day, options[:time] )
    diagnostics = false

    format = options[:format]
    case format
    when 'g'
      pp departures if diagnostics
      departures_group = departures
              .select { |dep| /^12/ =~ dep["aimed_departure_time"] }
              .group_by { |d| d["destination_name"] }.sort
      departures_group.each do |stat, train_list|
        dep_times = train_list.map{|x| x["aimed_departure_time"] [3..4] }
             .join(" ")
        printf "    %-30s %2d %-10s %-30s\n", stat, train_list.count,
             train_list[0]["mode"], dep_times
      end
    when 'd'
       disp_stat = jour.display_stations
       print_departure_details departures, day,
           disp_stat.reverseif(options[:reverse]) , format

    when 'e','k'
       ## TODO: doesnt support reverse. is it right place
       print_departure_details departures, day, statpair, format

    when 'l'
       # Format = l (list)
       # TODO - default, do any shell scripts reply on it.
       mode = departures.length==0 ? 'none' : departures[0]["mode"]
       departures.each do |dep|
         dispmode = dep['mode'] == 'train' ? '' : dep['mode']
         printf "    %-10s %-3s %-3s  %-20s > %-20s\n",
           dep["aimed_departure_time"] ,
           dispmode ,
           dep['operator'] ,
           dep['origin_name'] ,
           dep["destination_name"]
         printf "    %-10s %-10s \n", dep['service'],dep['train_uid'] if options[:verbose]
        end
      else
        puts 'Bad option'
    end
  end
end

#---------------------------------------------------------------------------

def get_eng_sequence( options)
region = :gb_eng
# This is a workround. It doesnt seem to want to load :gb_eng unless already read :gb
## Date.today.holiday?(:gb) #  bodge

# Iterate over days, printing === for blocks of working days
day = options[:date]
done_separator = false
numdays = options[:numdays]
(1..numdays).each do |n|
   if options[:workday] || day.nonworkday?(region)
      getDeptOneDay( day, options ) ;
      done_separator = false
   else
      if !done_separator
         puts '-------------------------------------'
         done_separator = true
      end
   end

   day = day+1

end
end

#---------------------------------------------------------------------------
def helpandexit
    puts "please give a pair of stations EDW::LBG"
    exit
end
#---------------------------------------------------------------------------
options = {
        :journeylist => [],      # list of journey options
    :numdays => 1 ,

    :date => Date.today,
    :time => Time.now ,
    :workday => true ,
    :format => 'd'
}
OptionParser.new do |opts|
   opts.banner = "Usage: get_eng.rb  sss:ddd .... "

   opts.on("-f","--file FILE","Give filenameTODO" ) do |file|
     puts "Given file"
     options[:file]=file
   end

   opts.on("-d","--date DATE", Date, "specify date " ) do |date|
      options[:date] = date
   end
   opts.on("-r", "--reverse", "Reverse direction") do |v|
       options[:reverse] = v
   end
   opts.on("-t","--time DATE", Time, "specify time " ) do |time|
      options[:time] = time
   end
   opts.on("-w", "-s-[no-]workday", "Include weekdays") do |v|
       options[:workday] = v
   end
   opts.on("-n","--numdays NUM",Integer, "number of days",
       "counts both workday and weekday",
       "TODO - this is confusng, better to count number printed" ) do |numdays|
      options[:numdays] = numdays
   end

   opts.on("-f","--format FORMAT",
       "print format format",
       "   l - list trains (default)",
       "   g - group",
       "   d - details ",
       "   k - keyed : including leave time and notes",
       ) do |format|
      options[:format] = format
   end
   opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
       options[:verbose] = v
   end
   opts.environment
end.parse!

pp options if options[:verbose]
#helpandexit if ARGV.count == 0

ARGV.each do |a|
  #TODO validate
  options[:journeylist].push Journey.new( a.split ":" )
end
begin
  get_eng_sequence( options )
rescue Interrupt  => e
  puts ''
end
