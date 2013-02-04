#!/usr/bin/env ruby

#craet a random poker
def creatpoker(frequence)
  poker  = Array.new()
  i = 0;
  while(poker.length < frequence * 13)
    loop do  i = rand(14); break if i != 0  end

    if(poker.count(i.to_s) < frequence)
        poker.push(i.to_s)
    end
  end
  
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

#p = initpoker(2)
#puts cards = (1...11).to_a

class Person
  attr_reader :points

  def initialize(name)
      @name = name
      @points = 0
  end
  
  def add(card)
      @points += card.to_i      
  end

end

def calculate(person)
  sum = 0
  person.each do |x|
    sum = sum + x.to_i
  end
  sum
end

def getchoice
    s = gets.chomp
    while(s != "hit" && s != "stay")
        puts "please input the right choice"
        s = gets.chomp
    end
    s
end

def compare(p)
    puts "player:#{p[:player]} ~ dealer:#{p[:dealer]}"

    if p[:player] > p[:dealer]
        puts "player win!" 
    end
    if p[:player] < p[:dealer]
        puts "dealer win!" 
    end
    if p[:player] == p[:dealer]
        puts "tie!" 
    end
end



cards = (1...11).to_a.collect! { |x| x.to_s }
puts cards.to_s
#use .sample to relist it
cards = cards.sample(10)

points = { player: 0, dealer: 0}
player = Array.new(0)
dealer = Array.new(0)
list = Array.new(0)

if(cards.length < 9)
  puts "the card is wrong"
  return
end
card = cards.pop()
list.push(card)
player.push(card)
card = cards.pop()
list.push(card)
player.push(card)
points[:player] = calculate(player)

card = cards.pop()
list.push(card)
dealer.push(card)
card = cards.pop()
list.push(card)
dealer.push(card)
points[:dealer] = calculate(dealer)

loop do
    pstat = false
    dstat = false

    puts "Player, your cards : #{player.to_s}, points : #{points[:player]}
             please make a choice : hit or stay ... :)"
    choice = getchoice
    if(choice == "hit")
        pstat = false

        card = cards.pop()
        puts card.to_s
        list.push(card)
        player.push(card)
        points[:player] = calculate(player)

        if points[:player] > 21
            puts "Player bust"
            break;
        end
        if points[:player] == 21
            puts "Player win by 21"
            break;
        end
        puts "player's points is " +  points[:player].to_s

    else
        pstat = true
        if dstat == true
            compare(points)
            break;
        end
        puts "you choose to stay... now switch to dealer"  
    end

    puts "dealer,your cards : #{dealer.to_s}, points : #{points[:dealer]}."
    if points[:dealer] >= 17
       choice = "stay" 
    else
       choice = hit
    end
    if(choice == "hit")
        dstat = false

        card = cards.pop()
        puts card.to_s
        list.push(card)
        dealer.push(card)
        points[:dealer] = calculate(dealer)

        if points[:dealer] > 21
            puts "dealer bust, and player win!"
            break;
        end
        if points[:dealer] == 21
            puts "dealer win by 21"
            break;
        end
        puts "dealer's points is " +  points[:dealer].to_s


    else
        dstat = true
        if pstat == true
            compare(points)
            break;
        end
        puts "you choose to stay... now switch to player"  
    end


end




