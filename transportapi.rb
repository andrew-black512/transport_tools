require 'httparty'
require 'logger'

class TransportAPI
  include HTTParty
  # TODO the v3/uk/train could be paramatarised
  base_uri 'transportapi.com/v3/uk/train'
  #logger  ::Logger.new("httparty.log")

  def initialize
    @options = { query: {api_key:'e007c65598b617695cdec19c8349656f', app_id:'71b00a99'} }
  end

  def timetabletimes( fromstation, day, time )
      parstring = [
  	  fromstation,
  	  day.strftime("%Y-%m-%d") ,
  	  time.strftime("%H:%M"),    #TODO
  	  'timetable.json'
       ].join '/'
       puts parstring
       self.class.get("/station/" + parstring, @options)
  end

  # Returns an array of   departures... TODO names
  def tt_depart( fromstation, day, time )
    resp = timetabletimes( fromstation, day, time )
    #pp resp
    resp   ['departures'] ['all']
  end

  # service
  #  Note may want to speficy        @options ['station_code'] = 'ECR'
  def service( servicenumber, day )
      parstring = [
  	  'train_uid:' + servicenumber,
  	  day.strftime("%Y-%m-%d") ,
  	  'timetable.json'
       ].join '/'
       self.class.get("/service/" + parstring, @options)
  end
end

