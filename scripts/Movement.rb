class Movement
  attr_accessor :x, :y
  def initialize(speed,x,y)
    @speed,@x,@y=speed,x,y
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

end

