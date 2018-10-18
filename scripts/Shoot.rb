require_relative 'Definitions'
require_relative 'Texture'
require_relative 'Movement'
class Shoot
  def initialize
    @texturePath='./assets/textures/shoot.png'
    @Texture = Texture.new(@texturePath,0.05,0.05)
    @speed,@x,@y=1.5,Definitions::RES_WIDTH-350,100
    @Movement=Movement.new(@speed,@x,@y)
  end

  def MoveLeft
    @Movement.left
  end
  def MoveRight
    @Movement.right
  end

  def draw
    @Texture.drawRotacionado(@Movement.x,@Movement.y,(9/36)*6.28)
  end
end