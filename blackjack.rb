# Calculate card total  
def calculate_total(cards)
  card_faces = cards.map {|card| card[0]}
  total = 0
  card_faces.each do |number|
    if number == 'Ace'
      total += 11
    elsif number.to_i == 0
      total += 10
    else
      total += number.to_i
    end
  end
# Accounting for aces
  number_of_aces = card_faces.count('Ace')
  while total  >  21 && number_of_aces > 0
    total -= 10
    number_of_aces -= 1
  end
  total
end

# Create deck
suits = [' of Clubs', ' of Hearts', ' of Diamonds', ' of Spades']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']
deck = cards.product(suits)
deck.shuffle!

# Display individual cards
def individual_card(card) 
  card[0] + card[1]
end
  
# Welcome message
puts "Hi, there, kid. What's your name?"
player_name = gets.chomp
player_name = "Player" if player_name.empty?
puts "Alrighty, #{player_name}, let's start a game of BlackJack."
sleep 2

# Possible outcomes - messages
dealer_win = "****Dealer won! Sorry, you lost, #{player_name}.****"
player_win = "****You won, #{player_name}!****"
dealer_win_blackjack = "****Blackjack! Dealer won! Sorry, you lost, #{player_name}.****"
player_win_blackjack = "****Blackjack! You won, #{player_name}!****"
player_bust = "****Bust! Sorry, #{player_name}.****"
dealer_bust = "****Dealer bust! You won, #{player_name}!****"
push = "****Push! It's a tie, #{player_name}!****"

#GAMEPLAY
loop do
  system "clear"
  
# Create empty hands
  player_cards = []
  dealer_cards = []
  
# Deal
  puts "Dealing..."
  2.times do
    player_cards << deck.pop
    dealer_cards << deck.pop
  end

  player_total = calculate_total(player_cards)
  dealer_total = calculate_total(dealer_cards)
  sleep 1
  puts "Ok, #{player_name}, you have '#{individual_card(player_cards[0])}' and '#{individual_card(player_cards[1])}' for a total of #{player_total}."
  puts "Dealer's upcard is '#{individual_card(dealer_cards[1])}'."
  puts "-------------------------"

# Player's turn
  if player_total == 21 
    puts player_win_blackjack
    puts "-------------------------"
    puts "Would you like to play again, #{player_name}? (yes/no)"
    redo if gets.chomp.downcase == 'yes'
    break
  elsif player_total > 21 
    puts player_bust
    puts "-------------------------"
    puts "Would you like to play again, #{player_name}? (yes/no)"
    redo if gets.chomp.downcase == 'yes'
    break
  end

  while player_total < 21
    puts "What would you like to do, #{player_name}? (hit/stay)"
    hit_stay = gets.chomp.downcase   
    until ['hit', 'stay'].include?(hit_stay)
      puts "You must choose. (hit/stay)"
      hit_stay = gets.chomp.downcase
    end
    if hit_stay == 'stay'
      puts "You chose to stay."
      break
    end
    player_cards << deck.pop
    player_total = calculate_total(player_cards)
    puts "You chose to hit. You've added '#{individual_card(player_cards.last)}' and your total is #{player_total}."
  end

  puts "-------------------------"
  if player_total > 21 
    puts player_bust
    puts "-------------------------"
    puts "Would you like to play again, #{player_name}? (yes/no)"
    redo if gets.chomp.downcase == 'yes'
    break
  end
  sleep 1

# Dealer's turn
  puts "-------------------------"
  puts "Dealer's turn."
  puts "Dealer's upcard is '#{individual_card(dealer_cards[1])}'. Dealer reveals downcard as '#{individual_card(dealer_cards[0])}'. Dealer's total is #{dealer_total}."
  puts "-------------------------"
  sleep 1

  if dealer_total == 21
    puts dealer_win_blackjack
    puts "-------------------------"
    puts "Would you like to play again, #{player_name}? (yes/no)"
    redo if gets.chomp.downcase == 'yes'
    break
  end

  while dealer_total < 17
    dealer_cards << deck.pop
    dealer_total = calculate_total(dealer_cards)
    puts "Dealer hits. Dealer adds '#{individual_card(dealer_cards.last)}' for a total of #{dealer_total}."
    sleep 1
  end  
  puts "-------------------------"

  if dealer_total > 21
    puts dealer_bust
  elsif dealer_total == player_total
    puts "Your total: #{player_total}. Dealer total: #{dealer_total}." 
    puts push
  elsif dealer_total == 21
    puts "Your total: #{player_total}. Dealer total: #{dealer_total}."
    puts dealer_win
  elsif dealer_total > player_total
    puts "Your total: #{player_total}. Dealer total: #{dealer_total}." 
    puts dealer_win
  elsif dealer_total < player_total
    puts "Your total: #{player_total}. Dealer total: #{dealer_total}." 
    puts player_win
  end
  sleep 1

  puts "-------------------------"
  puts "Would you like to play again, #{player_name}? (yes/no)"
  break if gets.chomp.downcase != 'yes'
end 
