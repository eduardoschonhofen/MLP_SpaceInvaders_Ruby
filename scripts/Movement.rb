class Movement
  attr_accessor :x, :y, :width, :height
  def initialize(speed, x, y, width, height)
    @speed, @x, @y, @width, @height = speed, x, y, width, height
  end

  def warp(x,y)
    @x,@y=x,y
  end

  def left
    @x-=@speed
  end

  def right
    @x+=@speed
  end

  def top
    @y-=@speed
  end

  def down
    @y+=@speed
  end

end
