#!/usr/bin/env ruby
require 'rubygems'
require 'pry'

class Card
  attr_reader :suit, :face_value
  def initialize(s, fv)
    @suit = s
    @face_value = fv
  end
  
  def find_suit
    ret = case suit
          when 'H' then "Hearts"
          when 'D' then "Diamonds"
          when 'S' then "Spades"
          when 'C' then "Clubs"
          end 
    ret
  end

  def pretty_output
    puts "The #{face_value} of #{find_suit}"
  end

  def to_s
    pretty_output
  end

end

card  = Card.new("H", 2)
card.to_s
exit

#craet a random poker
#p = initpoker(num). 1-> 13; 2 -> 26; 3 -> 39; 4 -> 52.
def creatpoker(frequence)
  poker  = Array.new()
  i = 0;
  while(poker.length < frequence * 13)
    loop do  i = rand(14); break if i != 0  end

    if(poker.count(i.to_s) < frequence)
        poker.push(i.to_s)
    end
  end

  poker.collect! do |x|
    if(x == "1"); x = "A"; end
    if(x == "11"); x = "J"; end
    if(x == "12"); x = "Q"; end
    if(x == "13"); x = "K"; end
    x
  end

  puts poker.to_s
  puts poker.sort.to_s

  return poker
end

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

#programe starts here

cards = (1...11).to_a.collect! { |x| x.to_s }
puts cards.to_s
#use .sample to reindex it
cards = cards.sample(10, random:rand(10))
puts cards.to_s

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
        puts "player's points is " +  points[:player].to_s

        if points[:player] > 21
            puts "Player bust"
            break;
        end
        if points[:player] == 21
            puts "Player win by 21"
            break;
        end

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
       choice = "hit"
    end
    if(choice == "hit")
        dstat = false

        card = cards.pop()
        puts card.to_s
        list.push(card)
        dealer.push(card)
        points[:dealer] = calculate(dealer)
        puts "dealer's points is " +  points[:dealer].to_s

        if points[:dealer] > 21
            puts "dealer bust, and player win!"
            break;
        end
        if points[:dealer] == 21
            puts "dealer win by 21"
            break;
        end

    else
        dstat = true
        puts "you choose to stay... now switch to player"  
    end


end




