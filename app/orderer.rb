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
			orderable = Orderable.new({:task => task, :dependency => @dependencies[task]})
			@to_order << orderable
		end
		self.to_order
	end

	def order
		prepare_orderables if @to_order.empty?
		@tasks.each do |task|
			unless @dependencies.nil?
				dependency = @dependencies[task]
			end
			@orderable = Orderable.new({:task => task, :dependency => dependency})
			@to_order << @orderable.task
		end
		until (@ordered.length == @to_order.length)
			@to_order.each do |task|
				unless @orderable.dependent? && ((@ordered.include? @orderable.dependency) == false)
					@ordered << @orderable.task
				end
			end
		end
		@ordered
	end
end