require 'minitest/autorun'
require '../app/app'

class SequencerTest < Minitest::Test 
	def setup
		@sequencer = Sequencer.new
		@hash_abc = {
			"a" => "", 
			"b" => "c", 
			"c" => ""
		}

		@hash_long = {
			"a" => "",
			"b" => "c",
			"c" => "f",
			"d" => "a",
			"e" => "b",
			"f" => ""
		}

		@hash_self_dependent = {
			"a" => "",
			"b" => "",
			"c" => "c"
		}

		@hash_circular ={
			"a" => "",
			"b" => "c",
			"c" => "f",
			"d" => "a",
			"e" => "",
			"f" => "b"
		}
	end

	#1
	def test_it_works
		assert_equal 1, 1
	end

	#2
	def test_it_schedules_a_single_task
		assert_equal "a", @sequencer.schedule("a")
	end

	#3
	def test_it_schedules_multiple_tasks
		assert_equal "abc", @sequencer.schedule("abc")
	end

	#4
	def test_it_schedules_multiple_tasks_with_a_single_dependency
		assert_equal "acb", @sequencer.schedule(@hash_abc)
	end

	#5
	def test_it_schedules_multiple_tasks_with_multiple_dependencies
		assert_equal "adfcbe", @sequencer.schedule(@hash_long)
	end

	#6
	def test_that_jobs_cant_depend_on_themselves
		assert_raises do 
			@sequencer.schedule(@hash_self_dependent)
		end
	end

end