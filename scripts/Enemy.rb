require_relative 'Definitions'
require_relative 'Texture'
require_relative 'Movement'
class Enemy
  attr_accessor :Movement

  def initialize(x,y)
    @texturePath='./assets/textures/tie.png'
    @Texture = Texture.new(@texturePath, 0.025, 0.025)
    @width, @height = @Texture.texture.width,@Texture.texture.height
    @x,@y = x, y
    @Movement=Movement.new(0.5, @x, @y, @width*0.025, @height*0.025)
  end

  def MoveLeft
    @Movement.left
  end

  def MoveRight
    @Movement.right
  end

  def MoveDown
    @Movement.down
  end

  def draw
    @Texture.draw(@Movement.x,@Movement.y)
  end

end