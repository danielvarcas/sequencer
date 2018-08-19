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

	def order
		prepare_orderables if @to_order.empty?
		until @ordered.length == @to_order.length
			@to_order.each do |orderable|
				if orderable.dependent?
					if (@ordered.include? orderable.dependency)
						@ordered.push(orderable.task) unless (@ordered.include? orderable.task)
					elsif orderable.self_dependent?
						@ordered.push(orderable.task) unless (@ordered.include? orderable.task)
					end
				else
					@ordered << orderable.task unless (@ordered.include? orderable.task)
				end
			end
		end
		@ordered
	end
end