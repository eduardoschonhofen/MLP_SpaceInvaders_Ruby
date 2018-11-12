require_relative 'Definitions'
require_relative 'Texture'
require_relative 'Movement'
require_relative 'GameObject'
class Shoot < GameObject
  attr_accessor :Movement

  def initialize(movement)
    @texturePath='./assets/textures/shoot.png'
    @scaleX,@scaleY=0.1,0.1
    @speed=6
    @soundPath="./assets/audios/playerfire.wav"
    super(movement.x+15  ,movement.y)
    loadSound()
    playSound()
  end



end
