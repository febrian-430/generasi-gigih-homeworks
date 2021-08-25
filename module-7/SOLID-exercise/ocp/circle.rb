class Circle
    attr_accessor :radius
  
    def initialize(radius)
      @radius = radius
    end
  
    def area
      3.14*@radius*@radius
    end
end