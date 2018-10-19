require_relative 'Definitions'
require_relative 'Texture'
require_relative 'Movement'
class Player
  attr_accessor :Movement

  def initialize
    @texturePath='./assets/textures/xwing.png'
    @Texture = Texture.new(@texturePath, 0.1, 0.1)
    @speed,@x,@y= 2,Definitions::RES_WIDTH/2,Definitions::RES_HEIGHT-80
    @width, @height = 64, 64
    @Movement=Movement.new(@speed, @x, @y, @width, @height)
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

  def collect_stars(stars)
    if stars.reject!{|star| Gosu::distance(@x,@y,star.x,star.y)<35} then
      @score+=1
      @beep.play
      true
    else
      false
    end
  end
end
