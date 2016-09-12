#!/usr/bin/env ruby

require './lib/player'
Dir['./lib/others/*.rb'].each{|f| require f}

player_classes = ObjectSpace.each_object(Class).select{|o| [:name, :move].all?{|m| o.instance_methods.include?(m)}}

players = []

player_classes.each do |player_class|
  players << {
    player: player_class.new,
    score: 100,
    moves: []
  }
end

playing = players.select{|p| p[:score] > 0}

while playing.size > 1
  scores = players.map{|p| p[:score]}
  
  playing.each do |p|
    move = [p[:player].move('armies' => scores, 'soldiers' => p[:score]), 1].max
    p[:score] -= move
    p[:moves] << move
  end
  
  by_bet = playing.sort_by{|p| 0-p[:moves].last}
  winner = by_bet[0]
  
  remaining = winner[:moves].last - by_bet[1][:moves].last

  bonus = remaining
  by_bet[1..-1].each do |player|
    bonus += [remaining, player[:moves].last].min
  end
  
  winner[:score] += bonus

  playing = players.select{|p| p[:score] > 0}
end

puts sprintf("%-20s %12s %16s", 'Player', 'Final Score', 'Rounds Survived')
players.sort_by{|p| 0-p[:score]}.sort_by{|p| 0-p[:moves].size}.each do |p|
  puts sprintf("%-20s %12d %16d", p[:player].name, p[:score], p[:moves].size)
end