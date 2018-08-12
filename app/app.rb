require_relative '../test/orderable_test'

class Orderable
	attr_accessor :tasks, :dependencies

	def initialize(params = {})
		@tasks = params.fetch(:tasks, nil)
		@dependencies = params.fetch(:dependencies, nil)
	end

	def order
		@order = []
		task_array = @tasks.split(//)
		until (@order.length == @tasks.length)
			task_array.each do |task|
				@order << task
			end
		end
		@order.join
	end

	def dependent?(params ={})
		task = params.fetch(:task, nil)
		dependencies = params.fetch(:dependencies, nil)
		unless dependencies[task].nil?
			return true
		else
			return false
		end
	end

	def self_dependent?(params = {})
		task = params.fetch(:task, nil)
		dependencies = params.fetch(:dependencies, nil)
		if task == dependencies[task]
			return true
		else
			return false
		end
	end
end