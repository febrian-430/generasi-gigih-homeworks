require './employee'

describe Employee do 
 it "can get full name" do
  employee = Employee.new("Dian", "Sasa", 3, 0.2)

  expect(employee.full_name).to eq("Dian Sasa")
 end
 
end
