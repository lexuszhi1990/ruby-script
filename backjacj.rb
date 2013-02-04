#!/usr/bin/env ruby

def initpoker(frequence)
  poker  = Array.new
  i = 0;
  while(poker.length < frequence * 13)
    loop do  i = rand(14); break if i != 0  end
    
    if(poker.count(i) < frequence)
      poker.push(i)
    end
  end

  puts poker.sort.to_s
  puts poker.to_s

  return poker
end

#p = initpoker(4)






