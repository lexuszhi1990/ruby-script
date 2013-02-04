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

cards = (1...11).to_a.collect! { |x| x.to_s }
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

card = cards.pop()
list.push(card)
dealer.push(card)
card = cards.pop()
list.push(card)
    dealer.push(card)

def calculate(person)
  sum = 0
  person.each do |x|
    sum = sum + x.to_i
  end
  sum
end

loop do
    pstat = false
    dsate = false

    puts "player, please make a choice : hit or stay ... :)"
    choice = gets.chomp
    if(choice == "hit")
        pstat = false

        card = cards.pop()
        puts card.to_s
        list.push(card)
        player.push(card)
        points[:player] = calculate(player)

        if points[:player] > 21
            puts "Player lose"
        end
        if points[:player] == 21
            puts "Player win"
        end
        puts "player's points is " +  points[:player].to_s

    else
        pstat = true
        puts "you choose to stay... now switch to dealer"  
    end

    puts "dealer, please make a choice : hit or stay ... :)"
    choice = gets.chomp
    if(choice == "hit")
        dstat = false

        card = cards.pop()
        puts card.to_s
        list.push(card)
        dealer.push(card)
        points[:dealer] = calculate(dealer)

        if points[:dealer] > 21
            puts "dealer lose"
        end
        if points[:dealer] == 21
            puts "dealer win"
        end
        puts "dealer's points is " +  points[:dealer].to_s


    else
        dstat = true
        puts "you choose to stay... now switch to player"  
    end





    if(pstat == true && dstat == true) 
      
      break;
    end
end




