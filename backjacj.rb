#!/usr/bin/env ruby

def initpoker(frequence)
  poker  = Array.new()
  i = 0;
  while(poker.length < frequence * 13)
    loop do  i = rand(14); break if i != 0  end

    if(poker.count(i.to_s) < frequence)
        poker.push(i.to_s)
    end
  end

  
  puts poker.to_s
  puts poker.sort.to_s

  poker.collect! do |x|
    if(x == "1"); x = "A"; end
    if(x == "11"); x = "J"; end
    if(x == "12"); x = "Q"; end
    if(x == "13"); x = "K"; end
    x
  end
  puts poker.to_s

  return poker
end

p = initpoker(2)

cards = ["A"] + (2...10).to_a.collect!{ |x| x.to_s }



