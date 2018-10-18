require_relative 'Definitions'

class Texture
  def initialize(path,scaleX,scaleY)
    @RES_WIDTH=Definitions::RES_WIDTH
    @RES_HEIGHT=Definitions::RES_HEIGHT
    @texture =Gosu::Image.new(path,{})
    @scaleX,@scaleY=scaleX,scaleY
  end




  def draw(x,y)
    @texture.draw(x,y,1,@scaleX,@scaleY)
  end

  def drawRotacionado(x,y,angle)
    @texture.draw_rot(angle=angle,x=x,y=y,z=1,scale_x=@scaleX,scale_y=@scaleY)
  end

end