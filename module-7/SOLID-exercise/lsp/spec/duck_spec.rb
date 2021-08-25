require './duck'

describe Duck do 
 it "can sound" do
  duck = Duck.new
  expect(duck.sound).to eq("quack")
 end
 it "will fly" do
  duck = Duck.new
  expect(duck.fly).to eq("I will fly!")
 end
end
