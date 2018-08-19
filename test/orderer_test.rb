require 'minitest/autorun'
require '../app/orderer'
require 'pry'

class OrdererTest < Minitest::Test 

	def attributes_test(assertion, expected)
		assertion.each_with_index do |x, index|
			if ((assertion[index].task == expected[index].task) && (assertion[index].dependency == expected[index].dependency))
				return true
			else
				return false
			end
		end
	end

	def test_it_prepares_orderables
		@orderer 	= Orderer.new({
			:tasks => "abc", 
			:dependencies => {"a" => "", "b" => "c", "c" => ""}
		})

		@a 			= Orderable.new({:task => "a",	:dependency => ""	})
		@b 			= Orderable.new({:task => "b",	:dependency => "c"	})
		@c 			= Orderable.new({:task => "c",	:dependency => ""	})

		assertion = [@a,@b,@c]
		false_assertion = [@b]
		expected = @orderer.prepare_orderables
		assert  attributes_test(assertion, expected) == true
		assert attributes_test(false_assertion, expected) == false 
	end

	def test_it_orders_a_single_task
		@orderer = Orderer.new(:tasks => "a")
		assert_equal ["a"], @orderer.order
	end
	
	def test_it_orders_multiple_tasks
		@orderer = Orderer.new(:tasks => "abc")
		assert_equal ["a","b","c"], @orderer.order
	end
	
	def test_it_orders_tasks_with_dependencies
		@orderer = Orderer.new({:tasks => "abc", :dependencies => {"a" => "", "b" => "c", "c" => ""}})
		assert_equal ["a","c","b"], @orderer.order
	end

	def test_it_orders_self_dependents
		@orderer = Orderer.new({:tasks => "abc", :dependencies => {"a" => "", "b" => "b", "c" => ""}})
		assert_equal ["a","b","c"], @orderer.order
	end

	def test_it_orders_self_dependents_and_other_dependencies
		@orderer = Orderer.new({:tasks => "abc", :dependencies => {"a" => "a", "b" => "c", "c" => ""}})
		assert_equal ["a","c","b"], @orderer.order
	end

	def test_it_doesnt_order_tasks_with_circular_dependencies
		@orderer = Orderer.new({:tasks => "abcd", :dependencies => {"a" => "", "b" => "c", "c" => "b", "d" => ""}})
		assert_equal ["a", "d"], @orderer.order
	end

	def test_it_deals_with_circulars_and_other_dependencies
		@orderer = Orderer.new({:tasks => "abcde", :dependencies => {"a" => "e", "b" => "c", "c" => "b", "d" => "", "e" => ""}})
		assert_equal ["d", "e", "a"], @orderer.order
	end
end