require 'restaurant'
require 'support/string_extend'
class Guide

   class Config
	@@action = ['list', 'add', 'quit']

	def self.actions; @@action; end
   end



	def initialize(path = nil)	

	Restaurant.file_loc(path)

	if Restaurant.file_usable?
	puts "Restaurant file found"
	elsif Restaurant.create_file
	puts "Restaurant  File is created"
	else
	puts "Exiting.\n"
	exit!
	end
	end


	def launch
	introduction
	
	result = nil
	until result == :quit
	action = get_action
	result = do_action(action)
	end
	
	conclusion
	end

		

	def get_action
	action = nil
	
	loop do
	print "> "
	action = gets.chomp.downcase.strip
	if Guide::Config.actions.include?(action)
	return action
	break
	else
	puts "Actions: #{Guide::Config.actions.join(', ')}"
	end
	end

	end
	
	def do_action(input)
	case (input)
	when "list"
	list
	when "add"
	add
	when "quit"
	return :quit
	else
	puts "\nI don't understand the command\n"
	end
	end

	def introduction
	puts "<<<<<Welcome to Zomato-Engine App>>>>>\n\n"
	puts "This is an interactive way to find food as per your choice\n\n\n"
	end

	def conclusion
	puts "\nThank you for using the Zomato-Engine\n"
	puts "***** Good Bye and Bon Apetite!*****\n\n\n"
	end

	def add
	Restaurant.build_yourself
	hotel = Restaurant.new

	if hotel.save
	puts "\nRestaurant Saved Successsfully\n"
	else
	puts "\nSave Error! Please try again\n"
	end
	end

	def list
	output_header("Listing Restaurants")
	restaurants = Restaurant.saved_restaurant	
	output_restaurant_table(restaurants) 
	end

	def output_header(text)
	puts "\n#{text.upcase.center(60)}\n\n"
	end

	def output_restaurant_table(restaurants=[])

	print " Name".ljust(23)
	print " Cuisine".ljust(20)
	print " Rate\n".rjust(4)
	puts "-"*55

	restaurants.each do |rest|
	line = " #{rest.name.titleize.ljust(20)}"
	line << " #{rest.cuisine.titleize.ljust(20)}"
	line << " #{rest.formatted_rate.titleize.rjust(6)}"
	puts line
	end

	puts "No Listing found\n" if restaurants.empty?
	puts "-"*55
	end

end
