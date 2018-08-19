require_relative '../test/counter_test'

class Counter
	attr_accessor :count, :starting_count

	def initialize(count)
		@starting_count = count
		@count = count
	end

	def decrease(number=1)
		@count = @count - number
	end

	def reset
		@count = @starting_count
	end

	def done?
		if @count <= 0
			true
		else
			false
		end
	end
end