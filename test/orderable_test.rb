require 'minitest/autorun'
require '../app/orderable'

class OrderableTest < Minitest::Test 
	def setup
	end

	def test_it_works
		assert_equal 1, 1
	end

	def test_it_accepts_a_task
		@orderable = Orderable.new(:task => "a")
		assert_equal "a", @orderable.task
	end

	def test_it_accepts_a_dependency
		@orderable = Orderable.new(:dependency => "c")
		assert_equal "c", @orderable.dependency
	end

	def test_it_checks_dependency
		@orderable = Orderable.new(:dependency => {"b" => "c"})
		assert_equal true, @orderable.dependent?
	end

	def test_it_checks_for_self_dependency
		@orderable = Orderable.new(:task => "c", :dependency => "c")
		assert_equal true, @orderable.self_dependent?
	end
end