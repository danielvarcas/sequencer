require 'minitest/autorun'
require '../app/counter'

class CounterTest < Minitest::Test 
	def test_it_initialises_starting_count
		counter = Counter.new(3)
		assert_equal 3, counter.starting_count
	end

	def test_it_initialises_count
		counter = Counter.new(3)
		assert_equal 3, counter.count
	end

	def test_it_decreases_count
		counter = Counter.new(10)
		assert_equal 7, counter.decrease(3)
	end

	def test_it_resets_count
		counter = Counter.new(10)
		counter.decrease(5)
		assert_equal 10, counter.reset
	end
end