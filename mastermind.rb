class Player
  
  attr_reader :player
  
  def initialize(player)
  	@player = player
  end

end

class Game
  
  def initialize(player)
  	@player = player
  	welcome_message
  end

  def welcome_message
  	puts "Welcome to Mastermind #{@player}, are you ready to play? (Y / N)"
  	user_input = gets.chomp.downcase

  	if user_input == "y"
  		computer_chooses_random_colors
  	elsif user_input == "n"
  		exit
  	else
  		puts "Please enter Y or N"
  		welcome_message
  	end			
  end

  def computer_chooses_random_colors
  	computer_choices = 4.times.map { rand(1..4) }
  	convert_to_colors(computer_choices)
  end

  def convert_to_colors(arr)
  	arr.map! do |number|
  	  if number == 1
  	  	number = "Red"
  	  elsif number == 2
  	  	number = "Blue"
  	  elsif number == 3
  	  	number = "White"
  	  elsif number == 4
  	  	number = "Green"
  	  end
  	end
  end
end
x =  Game.new("Harry")
x