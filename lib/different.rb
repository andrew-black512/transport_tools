class Different
  attr :previous   # array of 2 stations

  def initialize(  )
  end

  def different( v )
     r = (@previous !=nil) && ( @previous != v )

     puts "#{v} #{r}"
     @previous = v
     return r
  end



end
def t
  d= Different.new
  put d.different 1
  put d.different 1
  put d.different 2
  put d.different 1

end
