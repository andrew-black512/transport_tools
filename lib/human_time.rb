require 'chronic'

## TODO: maybe create a separate _time version
def human_date( string )
  transform = {
    'tom' => 'tomorrow'  , # shades of VMS
  }
  if s=transform[ string ]
    string = s
    #puts "using #{s}"
  #when /^+(\d)/ # # TODO: add +dayd
  end
  time = Chronic.parse(string, :endian_precedence => :little)
    # TODO || raise "bad format#{s}"
  return time.to_date
end
