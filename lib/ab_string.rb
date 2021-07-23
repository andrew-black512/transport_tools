# class ABString
   def self.removebrackets ( str )
     # Not the most over exiting, but a hassle to keep rewriting and quoting ( )
     replacestr = str.gsub( / \( [^\)]* \) /x, '' )
     return replacestr
   end

# end
