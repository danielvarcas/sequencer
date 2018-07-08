require_relative '../test/sequencer_test'

class Sequencer
	def schedule(tasks)
		if tasks.class == String
			return tasks
		end

		if tasks.class == Hash
			@counter = tasks.length
			@order = []
			until (@counter == 0) || (@order.length == tasks.length) 
				tasks.each do |key, value|				
					if (@order.include? value) || (value == "")
						@order.push(key) unless @order.include? key
						@counter = tasks.length
					else
						@counter = @counter - 1
					end
				end
			end
			@order.join
		end
	end
end