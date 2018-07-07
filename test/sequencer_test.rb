require 'minitest/autorun'
require '../app/app'

class SequencerTest < Minitest::Test 
	def setup
		@sequencer = Sequencer.new
	end

	def test_it_works
		assert_equal 1, 1
	end

	def test_hello
		assert_equal @sequencer.hello, "Hello, world!"
	end
end