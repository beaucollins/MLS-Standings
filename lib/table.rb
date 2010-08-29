module Table
  
  class << self
    
    def included(base)
      puts "Included: #{base} (#{self})"
    end
    
    def extended(base)
      puts "Extended: #{base} (#{self})"
    end
    
  end
  
  def table &blk
    puts "doing table: #{self}"
    blk.call
  end
  
end