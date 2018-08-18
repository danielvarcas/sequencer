require_relative '../test/orderable_test'

class Orderable
	attr_accessor :task, :dependency

	def initialize(params = {})
		@task = params.fetch(:task, nil)
		@dependency = params.fetch(:dependency, nil)
	end

	def dependent?
		if self.dependency.nil?
			return false
		else
			return true
		end
	end

	def self_dependent?
		if task == dependency
			return true
		else
			return false
		end
	end
end