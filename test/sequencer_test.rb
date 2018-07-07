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
	end

	def test_it_works
		assert_equal 1, 1
	end

	def test_it_schedules_a_single_task
		assert_equal "a", @sequencer.schedule("a")
	end

	def test_it_schedules_multiple_tasks
		assert_equal "abc", @sequencer.schedule("abc")
	end

	def test_it_schedules_multiple_tasks_with_dependencies
		assert_equal "abc", @sequencer.schedule(@hash_abc)
	end
end