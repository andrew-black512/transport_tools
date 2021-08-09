class Different
  attr :previous   # array of 2 stations

  def initialize(  )
     @stat_list = stat_list.map { |s| s.upcase }
  end

  def different( v )
     r = previous && ( previous != v )

  end



end
def t
  d= Different.new
  put d.different 1
  put d.different 1
  put d.different 2
  put d.different 1

end
