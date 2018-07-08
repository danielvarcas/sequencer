require_relative '../test/sequencer_test'

class Sequencer
	def initialise
		@order = []
	end

	def schedule(tasks)
		if tasks.class == String
			return tasks
		end

		if tasks.class == Hash
			counter = tasks.length
			tasks.each do |key, value|
				until counter == 0
					if @order.include? value
						@order.push(key) unless @order.include? key
					else
						counter = counter - 1
					end
				end
			end
			@order
		end
	end
end