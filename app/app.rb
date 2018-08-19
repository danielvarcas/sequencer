require '../app/orderable'
require '../app/orderer'
require '../test/app_test'
require '../app/counter'
require 'pry'

class App
	def get_tasks
		puts "Input tasks:"
		@tasks = gets.chomp
		puts @tasks
	end

	def welcome
		puts "=== Welcome ==="
		get_tasks
	end 
end