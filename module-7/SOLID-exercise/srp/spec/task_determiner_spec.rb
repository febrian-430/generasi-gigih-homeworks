require './task_determiner'

describe TaskDeterminer do 
	it "can determine monday task" do
 		task_determiner = TaskDeterminer.new()
 		expect(task_determiner.task("monday", "Dian Sasa")).to eq("Dian Sasa implement birthday calculator")
 	end
	it "can determine wednesday task" do
 		task_determiner = TaskDeterminer.new()
 		expect(task_determiner.task("wednesday", "Dian Sasa")).to eq("Dian Sasa add birthday entries")
 	end
	it "can have default task task" do
 		task_determiner = TaskDeterminer.new()
 		expect(task_determiner.task("friday", "Dian Sasa")).to eq("Dian Sasa will fix issues")
 	end
end
