require 'minitest/autorun'
require '../app/app'

class SequencerTest < Minitest::Test 
	def setup
		@sequencer = Sequencer.new
	end

	def test_it_works
		assert_equal 1, 1
	end
end