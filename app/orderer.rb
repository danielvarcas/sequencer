require_relative '../test/orderer_test'
require 'pry'

class Orderer
	attr_accessor :tasks, :dependencies, :to_order, :ordered

	def initialize(params = {})
		@tasks = params.fetch(:tasks, nil).split(//)
		@dependencies = params.fetch(:dependencies, nil)
		@to_order = []
		@ordered = []
	end

	def prepare_orderables
		@tasks.each do |task|
			params = {:task => task}
			unless @dependencies.nil?
				params[:dependency] = @dependencies[task]
			end
			orderable = Orderable.new(params)
			@to_order << orderable
		end
		self.to_order
	end

	def push_task(orderable)
		unless (@ordered.include? orderable.task)
			@ordered.push(orderable.task)
			@counter.reset
		end
	end

	def order
		prepare_orderables if @to_order.empty?
		@counter = Counter.new(@to_order.length)
		until @ordered.length == @to_order.length
			return @ordered if (@counter.done?)
			@to_order.each do |orderable|
				if orderable.dependent?
					if (@ordered.include? orderable.dependency)
						push_task(orderable)
					elsif orderable.self_dependent?
						push_task(orderable) 
					end
				else
					push_task(orderable)
				end
				@counter.decrease
			end
		end
		@ordered
	end
end