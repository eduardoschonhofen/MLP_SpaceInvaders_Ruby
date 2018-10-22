require_relative 'Definitions'
require_relative 'Texture'
require_relative 'Movement'
class Shoot
  attr_accessor :Movement

  def initialize(movement)
    @texturePath='./assets/textures/shoot.png'
    @Texture = Texture.new(@texturePath, 0.1, 0.1)

    @speed,@x,@y= 6, movement.x+15  ,movement.y
    @width, @height = @Texture.texture.width,@Texture.texture.height
    @Movement=Movement.new(@speed, @x, @y, @width*0.1, @height*0.1)
  end

  def MoveLeft
    @Movement.left
  end

  def MoveRight
    @Movement.right
  end

  def MoveTop
    @Movement.top
  end

  def MoveDown
    @Movement.down
  end

  def draw
    @Texture.draw(@Movement.x,@Movement.y)
  end

  def out?
    if @Movement.y < 0 or @Movement.y > Definitions::RES_HEIGHT
      return true
    else
      return false
    end
  end
end
