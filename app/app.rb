require_relative '../test/sequencer_test'
require 'pry'

class Sequencer
	def schedule(tasks)
		@tasks = tasks

		# a string won't have dependencies
		if tasks.class == String
			return @tasks
		end

		# a hash might have dependencies
		if tasks.class == Hash

			# @counter: to iterate only for number of tasks in list - if all have been checked,
			# then @counter will be 0.  If @order.length is still less than @tasks.length
			# then there must be a circular dependency.  If @counter is 0 the program will
			# raise an exception.
			@counter = @tasks.length

			# @order: an array of tasks that have been put into the "load order"
			@order = []

			# Loop until @order and @tasks lengths are the same, meaning @order will contain
			# all tasks.
			until (@order.length == @tasks.length)

				# If there are no more tasks left to check and program is still looping, there
				# must be a circular dependency
				if @counter <= 0
					raise ArgumentError.new("Tasks cannot have circular dependencies.")
				end

				# Itereate through each task => dependency pair until above loop condition met
				tasks.each do |task, dependency|

					# check if task and dependency are the same (self-dependent) and raise error if so
					if task == dependency
						raise ArgumentError.new("Tasks cannot depend on themselves: #{key} => #{value}")
					end

					# if task is already in @order, decrease @counter
					if @order.include? task
						@counter = @counter -1
					
					# if dependency is already in @order or task has no dependency, push task to @order
					elsif (@order.include? dependency) || (dependency == "")
						@order << task
						# and reset counter
						@counter = @tasks.length

					# if dependency is not in @order, decrease counter
					else
						@counter = @counter - 1
					end
				end
				# start a REPL session
				#binding.pry
			end
			@order.join
		end
	end
end