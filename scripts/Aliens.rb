require_relative 'Definitions'
require_relative 'Texture'
require_relative 'Movement'
class Aliens
  attr_accessor :Movement

  def initialize(x,y)
    @texturePath='./assets/textures/tie.png'
    @Texture = Texture.new(@texturePath, 0.025, 0.025)
    @width, @height = 32, 32
    @x,@y = x, y
    @Movement=Movement.new(1, @x, @y, @width, @height)
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