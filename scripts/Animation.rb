require_relative 'Definitions'
class Animation
  def initialize(path,width,height)
    @RES_WIDTH=Definitions::RES_WIDTH
    @RES_HEIGHT=Definitions::RES_HEIGHT
    @animation = Gosu::Image::load_tiles(path,width,height,{})
  end

  def draw
    img = @animation[Gosu::milliseconds / 100 % @animation.size];
    img.draw(@x - img.width / 2.0, @y - img.height / 2.0,
             1, 1, 1)
  end

end