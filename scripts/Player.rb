require_relative 'Definitions'
require_relative 'Texture'
require_relative 'Movement'
class Player
  def initialize
    @texturePath='./assets/textures/xwing.png'
    @Texture = Texture.new(@texturePath,0.175,0.175)
    @speed,@x,@y=1.5,Definitions::RES_WIDTH,Definitions::RES_HEIGHT-100
    @Movement=Movement.new(@speed,@x,@y)
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