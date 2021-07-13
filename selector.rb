
class Selector

  def initialize( query_string)
    ## TODO: remember the seperator (how?)
    (@stop, @wanted_bus ) = query_string.split /[:^]/
    boring_buses = %w/P13 42/
    boring_buses.each do |x|
      @selector [x] = false
    end
  end
  def stop_name
    @stop
  end
  def wanted_bus ( bus )
    if @wanted_bus
      @wanted_bus [ bus ]
    else
      true
    end
  end

end
#!-------------------------------------------------------------------
#-- for test

def seltest(string)
  s = Selector.new( string )
  puts s.stop_name
  puts s.wanted_bus( "37")
  puts s.wanted_bus( "185")
end

seltest   "aaa:37"
seltest   "aaa"
