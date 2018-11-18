require_relative 'GameObject'
class EnemyShoot<GameObject

  def initialize(movement,alive=true)
    if alive
    @texturePath='./assets/textures/enemyshoot.png'
    @scaleX,@scaleY=0.1,0.1
    @speed= 6
    @soundPath="./assets/audios/enemyfire.wav"
    super(movement.x+15  ,movement.y)
    loadSound()
    playSound()
    else
    @alive=alive
      end
  end

  def move()
    if isAlive?
      moveDown

      if out?
        die
      end
    end
  end

end