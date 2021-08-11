class Different
  attr :previous   # array of 2 stations

  def initialize(  )
  end

  def different( v )
     r = (@previous !=nil) && ( @previous != v )

     @previous = v
     return r
  end



end
def t
  d= Different.new
  puts d.different 1
  puts d.different 1
  puts d.different 2
  puts d.different 1

end
