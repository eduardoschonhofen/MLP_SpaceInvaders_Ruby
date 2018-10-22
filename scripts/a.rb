require_relative 'Definitions'
require_relative 'Texture'
require_relative 'Movement'
class Enemy
  attr_accessor :Movement

  def initialize
    @texturePath='./assets/textures/tie.png'
    @Texture = Texture.new(@texturePath, 0.05, 0.05)
    @speed,@x,@y=1.5,Definitions::RES_WIDTH/2, 50
    @width, @height = @Texture.texture.width,@Texture.texture.height
    @Movement=Movement.new(@speed, @x, @y, @width*0.05, @height*0.05)
  end

  def MoveLeft
    @Movement.left
  end
  def MoveRight
    @Movement.right
  end

  def draw
    @Texture.draw(@Movement.x,@Movement.y)
  end

end
