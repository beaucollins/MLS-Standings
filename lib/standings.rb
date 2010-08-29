class Standings
  
  def initialize()
    @teams = []
    @conferences = {:east => [], :west => []}
  end
    
  def conference(name, &blk)
    # figure out east vs west
    return if name.nil? || !name.is_a?(String)
    conf = name[/east|west/i].downcase.intern
    @conferences[conf] ||= []
    
    teams = blk.call
    teams = [teams] unless teams.is_a?(Array)
    teams.each do |team|
      team.conference = conf
    end
    
    @conferences[conf] += teams
    
  end
  
  def seeded
    seeded = []
    # first the top two teams of each conference make it
    seeded += @conferences[:east][0,2]
    seeded += @conferences[:west][0,2]
  end
  
  # teams in the eastern conference
  def east
    @conferences[:east]
  end
  
  # teams in the western conference
  def west
    @conferences[:west]
  end
  
  # teams ranked for the whole league
  def league
    (@conferences[:east] + @conferences[:west]).sort {|team_a, team_b| team_b.points <=> team_a.points }
  end
  
  def wildcards
    (league - seeded)[0,4]
  end
  
  def remaining
    league - (seeded + wildcards)
  end

end
