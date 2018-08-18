require_relative '../test/orderer_test'
require 'pry'

class Orderer
	attr_accessor :tasks, :dependencies

	def initialize(params = {})
		@tasks = params.fetch(:tasks, nil).split(//)
		@dependencies = params.fetch(:dependencies, nil)
		@to_order = []
		@ordered = []
	end

	def show_order
		@order.join
	end

	def show_orderables
		@to_order.join
	end

	def prepare_orderables

	end

	def order
		@tasks.each do |task|
			unless @dependencies.nil?
				dependency = @dependencies[task]
			end
			orderable = Orderable.new({:task => task, :dependency => dependency})
			@to_order << orderable.task
		end
		until (@ordered.length == @to_order.length)
			@to_order.each do |task|
				@ordered << task
			end
		end
		@ordered
		#binding.pry
	end
end