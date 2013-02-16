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
    ret = case @suit
          when 'H' then "Hearts"
          when 'D' then "Diamonds"
          when 'S' then "Spades"
          when 'C' then "Clubs"
          end 
    ret
  end

  def pretty_output
    puts "The #{@face_value} of #{find_suit}"
  end

  def to_s
    pretty_output
  end

end

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    ['H', 'C', 'S', 'D'].each do |s|
      ['2', '3', '4', '5', '6', '7', '8','9',
                    '10', 'J', 'Q', 'K', 'A'].each do |fv|
          @cards << Card.new(s, fv)
      end
    end
    scramble!
  end

  def scramble!
    @cards.shuffle!
  end

  def size
    @cards.size
  end

  def deal_one
    @cards.pop
  end

  def to_s
    @cards.each do |card|
        card.pretty_output
    end
  end
end

module Hand
  attr_reader :name, :cards

  def initialize(name="ZHI")
      @name = name
      @cards = []
  end

  def show_hand
    puts "---- #{@name}'s Hand ----"
    @cards.each do |card|
      puts "=> #{card}"
    end
    puts "=> Total: #{total}"
  end
  
  def total
    face_values = cards.map { |card|  card.face_value}

    total = 0
    face_values.each do |fv|
        if fv == "A"
          total += 11
        else
          total += (fv.to_i == 0 ? 10 : fv.to_i)
        end
    end

    face_values.select { |val| val == 'A' }.count.times do 
      break if total <= 21
      total -= 10
    end
    
    total

  end
  
  def add_card(new_card)
    cards << new_card
  end

  def is_busted?
    total > Blackjack::BLACKJACK_AMOUNT
  end

end




class Player
  include Hand
  
end



class Blackjack
  BLACKJACK_AMOUNT = 21
end

binding.pry

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




