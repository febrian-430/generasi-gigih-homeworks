class SalaryCalculator
	def initialize(employee, tax)
		@employee = employee
		@tax = tax
	end

	def compute_pay
		case @employee.working_level
		when 1
			3000000 - (3000000 * @tax)
		when 2
			4000000 - (4000000 * @tax)
		when 3
			5000000 - (5000000 * @tax)
		else "unknown level"
		end
	end
end