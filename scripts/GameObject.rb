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



  def moveLeft
    @Movement.left
  end

  def moveRight
    @Movement.right
  end

  def moveDown
    @Movement.down
  end

  def moveTop
    @Movement.top
  end
  def draw
    if isAlive?
    @Texture.draw(@Movement.x,@Movement.y)
      end
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

  def move()
    if isAlive?
      moveTop

      if out?
        die
      end
    end
  end




  def playSound()
    @sound.play(volume=0.125)
  end

end