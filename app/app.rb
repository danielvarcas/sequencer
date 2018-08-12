require_relative '../test/sequencer_test'
# require 'pry'

class Sequencer
	def schedule(tasks)
		@tasks = tasks
		if tasks.class == String
			return @tasks
		end
		if tasks.class == Hash
			@counter = @tasks.length
			@order = []
			until (@order.length == @tasks.length)
				if @counter <= 0
					raise ArgumentError.new("Tasks cannot have circular dependencies.")
				end
				tasks.each do |task, dependency|
					if task == dependency
						raise ArgumentError.new("Tasks cannot depend on themselves: #{key} => #{value}")
					end
					if @order.include? task
						@counter = @counter -1
					elsif (@order.include? dependency) || (dependency == "")
						@order << task
						@counter = @tasks.length
					else
						@counter = @counter - 1
					end
				end
				#binding.pry
			end
			@order.join
		end
	end
end