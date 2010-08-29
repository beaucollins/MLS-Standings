class Stats
  
  attr_accessor :team, :conference
  
  STAT_FIELDS = [:goals_scored, :goals_against, :played, :wins, :draws, :losses, :rank]
  
  FIELDS = [:rank, nil, :team, :played, :wins, :draws, :losses, :goals_scored, :goals_against]
  
  def initialize(html)
    FIELDS.inject(self) { |me, field|
      me.send("#{field}=", html.search("td[#{Stats::FIELDS.index(field) + 1}]").to_s.gsub(/<\/?[a-z]+[^>]{0,}>/,'')) unless field.nil?
      me
    }
  end
  
  STAT_FIELDS.each do |field|
    
    define_method(field) do
      instance_variable_get("@#{field}")
    end
    
    define_method("#{field}=") do |val|
      instance_variable_set("@#{field}", val.to_i)
    end
    
  end
  
  def points
    (self.wins * 3) + self.draws
  end
  
  def conf
    {:east => 'East', :west => 'West'}[self.conference]
  end
    
  def to_s
    "#{team.ljust(20)} #{points} (#{point_percentage}%) (#{conf}-\##{rank})"
  end
  
  def point_percentage
    ((points.to_f/(played*3).to_f) * 100).round
  end
  
  def record(join='-')
    [wins, draws, losses].join(join)
  end
  
end
