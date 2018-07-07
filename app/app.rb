require_relative '../test/sequencer_test'

class Sequencer
	def schedule(tasks)
		if tasks.class == String
			tasks
		end

		if tasks.class == Hash
			order = []
			tasks.each do |task|
				order.push(task) unless order.include? task
			end
		end
	end
end