require_relative 'Definitions'
require_relative 'Texture'
require_relative 'Movement'
class GameObject

  attr_accessor :Movement
  def initialize(x,y)
    loadTexture(@texturePath)
    @width, @height = @Texture.texture.width*@scaleX,@Texture.texture.height*@scaleY
    @x,@y = x, y
    @alive=true
    setMovement(@speed)

  end
  def loadTexture(path)
    @Texture=Texture.new(path,@scaleX,@scaleY)
  end
  def setMovement(speed)
    @Movement=Movement.new(speed,@x,@y,@width,@height)
  end
  def loadSound()
    @sound=Gosu::Sample.new(@soundPath)
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

  def MoveTop
    @Movement.top
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

  def die()
    @alive=false
  end

  def isAlive?()
    return @alive
  end




  def playSound()
    @sound.play(volume=0.125)
  end

end