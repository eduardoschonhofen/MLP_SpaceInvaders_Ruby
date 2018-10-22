require_relative 'Definitions'

class Texture
  attr_accessor :texture
  def initialize(path,scaleX,scaleY)
    @RES_WIDTH=Definitions::RES_WIDTH
    @RES_HEIGHT=Definitions::RES_HEIGHT
    @texture =Gosu::Image.new(path,{})
    @scaleX,@scaleY=scaleX,scaleY
  end




  def draw(x,y)
    @texture.draw(x,y,1,@scaleX,@scaleY)
  end

  def drawBackground(x,y)
    @texture.draw(x,y,0,@scaleX,@scaleY)
  end

end