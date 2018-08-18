require 'minitest/autorun'
require '../app/orderer'

class OrdererTest < Minitest::Test 
	
	def test_it_orders_a_single_task
		@orderer = Orderer.new(:tasks => "a")
		assert_equal ["a"], @orderer.order
	end

# not yet implemented
=begin
	def test_it_orders_multiple_tasks
		@orderer = Orderer.new(:tasks => "abc")
		assert_equal ["a","b","c"], @orderer.order
	end

	def test_it_orders_tasks_with_dependencies
		@orderer = Orderer.new({:tasks => "abc", :dependencies => {"a" => "", "b" => "c", "c" => ""}})
		assert_equal ["a","c","b"], @orderer.order
	end
=end
end