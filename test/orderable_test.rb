require 'minitest/autorun'
require '../app/app'

class OrderableTest < Minitest::Test 
	def setup
	end

	def test_it_works
		assert_equal 1, 1
	end

	def test_it_accepts_and_returns_tasks
		@test = Orderable.new(:tasks => "abc")
		assert_equal "abc", @test.tasks
	end

	def test_it_accepts_and_returns_dependencies
		@test = Orderable.new(:dependencies => {"a" => "", "b" => "c", "c" => ""})
		assert_equal ({"a" => "", "b" => "c", "c" => ""}), @test.dependencies
	end

	def test_it_accepts_and_returns_both_tasks_and_dependencies
		@test = Orderable.new(:tasks => "abc", :dependencies => {"a" => "", "b" => "c", "c" => ""})
		assert_equal "abc", @test.tasks
		assert_equal ({"a" => "", "b" => "c", "c" => ""}), @test.dependencies
	end

	def test_it_orders_a_single_task
		@test = Orderable.new(:tasks => "a")
		assert_equal "a", @test.order
	end

	def test_it_orders_multiple_tasks
		@test = Orderable.new(:tasks => "abc")
		assert_equal "abc", @test.order
	end

	def test_it_checks_for_dependencies
		@test = Orderable.new(:dependencies => {"a" => "", "b" => "c", "c" => ""})
		assert_equal true, @test.dependent?(:task => "b", :dependencies => @test.dependencies)
	end

	def test_it_checks_for_self_dependencies
		@test = Orderable.new(:dependencies => {"a" => "", "b" => "", "c" => "c"})
		assert_equal true, @test.self_dependent?(:task => "c", :dependencies => @test.dependencies)
	end

	def test_it_schedules_multiple_tasks_with_a_single_dependency
		#@test = Orderable.new(:tasks => "abc", :dependencies => {"a" => "", "b" => "c", "c" => ""})
		#assert_equal "acb", @test.order
	end
end