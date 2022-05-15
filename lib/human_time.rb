require 'chronic'

def human_time( string )
  transform = {
    'tom' => 'tomorrow'  , # shades of VMS
  }
  if s=transform[ string ]
    string = s
    puts "using #{s}"
  #when /^+(\d)/ # # TODO: add +dayd
  end
  Chronic.parse(string, :endian_precedence => :little)
    # TODO || raise "bad format#{s}"
end
