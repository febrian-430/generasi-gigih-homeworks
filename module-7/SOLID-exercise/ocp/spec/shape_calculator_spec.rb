require './rectangle'
require './triangle'
require './circle'

require './shape_calculator'

describe ShapeCalculator do 
  it "can calculate the area of a rectangle" do
    rectangle = Rectangle.new(2, 3)
    shape_calculator = ShapeCalculator.new
    expect(shape_calculator.calculate_area(rectangle)).to eq(6)
  end

  it "can calculate the area of a triangle" do
    triangle = Triangle.new(2, 3)
    shape_calculator = ShapeCalculator.new
    expect(shape_calculator.calculate_area(triangle)).to eq(3)
  end

  it "can calculate the area of a circle" do
    circle = Circle.new(1)
    shape_calculator = ShapeCalculator.new
    expect(shape_calculator.calculate_area(circle)).to eq(3.14)
  end
end
