require_relative 'Definitions'
require_relative 'Texture'
require_relative 'Movement'
class Blocks
  attr_accessor :Movement

  def initialize(x,y)
    @texturePath='./assets/textures/block.jpg'
    @Texture = Texture.new(@texturePath, 0.5, 0.5)
    @width, @height = 32, 32
    @x,@y = x, y
    @Movement=Movement.new(1.5, @x, @y, @width, @height)
  end

  def MoveLeft
    @Movement.left
  end

  def MoveRight
    @Movement.right
  end

  def draw
    @Texture.draw(@x,@y)
  end

end