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

	def create_orderable(params={})
		orderable = Orderable.new(params)
		push_to_order(orderable)
	end

	def push_to_order(orderable)
		@to_order << orderable
	end

	def set_orderable_parameters(task)
		@params = {:task => task}
		unless @dependencies.nil?
			@params[:dependency] = @dependencies[task]
		end
	end

	def prepare_orderables
		@tasks.each do |task|
			set_orderable_parameters(task)
			create_orderable(@params)
		end
		self.to_order
	end

	def push_task(orderable)
		unless (@ordered.include? orderable.task)
			@ordered.push(orderable.task)
			@counter.reset
		end
	end

	def dependency_satisfied?(orderable)
		((@ordered.include? orderable.dependency) || orderable.self_dependent?) ? true : false
	end

	def check_orderable(orderable)
		if orderable.dependent?
			push_task(orderable) if dependency_satisfied?(orderable) 
		else
			push_task(orderable)
		end
		@counter.decrease
	end

	def setup_order
		prepare_orderables if @to_order.empty?
		@counter = Counter.new(@to_order.length)
	end

	def order
		setup_order
		until @ordered.length == @to_order.length
			return @ordered if @counter.done?
			@to_order.each do |orderable|
				check_orderable(orderable)
			end
		end
		@ordered
	end
end