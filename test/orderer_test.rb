require 'minitest/autorun'
require '../app/orderer'
require 'pry'

class OrdererTest < Minitest::Test 
	
	def test_it_orders_a_single_task
		skip
		@orderer = Orderer.new(:tasks => "a")
		assert_equal ["a"], @orderer.order
	end
	
	def test_it_orders_multiple_tasks
		skip
		@orderer = Orderer.new(:tasks => "abc")
		assert_equal ["a","b","c"], @orderer.order
	end
	

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

	def test_it_orders_tasks_with_dependencies
		skip
		@orderer = Orderer.new({:tasks => "abc", :dependencies => {"a" => "", "b" => "c", "c" => ""}})
		assert_equal ["a","c","b"], @orderer.order
	end
end