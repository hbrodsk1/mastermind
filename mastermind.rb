class Game
  
  def initialize(player)
  	@player = player
  	@computer_color_choices = []
  	@player_color_choices = []
  	@number_of_guesses = 0
  	@number_of_guesses_remaining = 12

  	welcome_message
  end

  def welcome_message
  	puts "\n\nWelcome to Mastermind #{@player}, are you ready to play? (Y / N)"
  	user_input = gets.chomp.downcase

  	if user_input == "y"
  		select_game_mode
  	elsif user_input == "n"
  		exit
  	else
  		puts "Please enter Y or N"
  		welcome_message
  	end			
  end

  def select_game_mode
  	puts "\n\nWould you like to guess the colors, or have the computer guess the colors? (Me / CPU)"
  	user_selection = gets.chomp.downcase

  	if user_selection == "me"
  		computer_chooses_random_colors
  	elsif user_selection == "cpu"
  		GameWithAI.new("Ghengis", @player)
  	else
  		puts "\n\nPlease enter Me or CPU"
  		select_game_mode
  	end
  end

  def computer_chooses_random_colors
  	@computer_color_choices = 4.times.map { rand(1..4) }
  	convert_to_colors(@computer_color_choices)
  end

  def convert_to_colors(arr)
  	arr.map! do |number|
  	  if number == 1
  	  	number = "red"
  	  elsif number == 2
  	  	number = "blue"
  	  elsif number == 3
  	  	number = "white"
  	  elsif number == 4
  	  	number = "green"
  	  end
  	end
  	guess_prompt
  end

  def guess_prompt
  	puts "\n\nPlease guess any sequence of these 4 colors, separated by a comma and space:"
  	puts "Red, Blue, White, Green"

  	get_player_input
  end

  def get_player_input
  	@player_color_choices = gets.chomp.split(", ").map! { |choice| choice.downcase }
  	check_player_input(@player_color_choices)
  end

  def is_valid?
  	valid_color_choices = ["red", "blue", "white", "green"]
  	
  	@player_color_choices.each do |input_to_check|
  		unless valid_color_choices.include?(input_to_check)
  			puts "\n\nInvalid Choice: #{input_to_check}"
  			return false
  		end
  	end
  	
  end

  def check_player_input(arr)	
  	if arr.length == 4 && is_valid?		
  		update_guess_count
  		check_for_correct_color_guesses
  	elsif arr.length != 4
  		puts "\n\nPlease make sure you enter 4 colors!"
  		guess_prompt
  	else
  		guess_prompt	
  	end
  end

  def update_guess_count
  	@number_of_guesses += 1
  	@number_of_guesses_remaining -= 1

  	if @number_of_guesses_remaining == 0
  		win_or_lose_message("lose")
  	end
  end

  def check_for_correct_color_guesses
  	correct_colors_count = 0
  	computer_color_choices = @computer_color_choices.dup

  	@player_color_choices.each do |player_color|
  		if computer_color_choices.include?(player_color)
  			correct_colors_count += 1
  			computer_color_choices.delete_at(computer_color_choices.index(player_color))
  		end		
  	end
  	puts "\n\nYou guessed #{correct_colors_count} colors correctly.\n\n" 
  	check_for_correct_placement_guesses
  end

  def check_for_correct_placement_guesses
  	correct_colors_and_placements_count = 0
  	index = 0

  	until index == @player_color_choices.length
  		if @player_color_choices[index] == @computer_color_choices[index]
  			correct_colors_and_placements_count += 1
  		end
  		index += 1
  	end

  	if correct_colors_and_placements_count == 4
  		win_or_lose_message("win")
  	else
  		puts "#{correct_colors_and_placements_count} of those colors are also in the correct spot.\n\n"
  		updated_guess_information
  	end
  end

  def updated_guess_information
  	puts "That was guess ##{@number_of_guesses}. You have #{@number_of_guesses_remaining} guesses left.\n\n"
  	puts "Keep guessing until you get all 4 colors in the correct spot!" "\n\n"
  	
  	next_turn
  end

  def next_turn
  	puts "Please guess again. Your last guess was:" 
  	print @player_color_choices.join(", ")
  	puts "\n\n"

  	get_player_input
  end

  def win_or_lose_message(str)
  	if str == "win"
  		puts "Congratulations, you guessed all the correct colors and all the correct spots!\n\n"
  	elsif str == "lose"
  		puts "Sorry, you are all out of guesses!"
  	end

  	play_again
  end

  def play_again
  	puts "Would you like to play again? (Y / N)\n\n"

  	user_input = gets.chomp.downcase

  	if user_input == "y"
  		Game.new(@player)
  	elsif user_input == "n"
  		exit
  	else
  		puts "Please enter Y or N\n\n"
  		play_again
  	end
  end
end

class GameWithAI < Game
  def initialize(computer, player)
  	@computer = computer
  	@player = player
  	computer_introduction
  end

  def computer_introduction
  	puts "\n\nHello #{@player}, I am #{@computer}. Are you ready to bong bong?"
  	puts "\n\nPlease select your colors. \nYou may type an combination and order of the follows colors:"
  	puts "Red, Blue, Green, White"
  end
end


Game.new("Harry")


