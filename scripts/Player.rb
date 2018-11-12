require_relative 'Definitions'
require_relative 'Texture'
require_relative 'Movement'
require_relative 'GameObject'
class Player < GameObject
  attr_accessor :Movement

  def initialize
    @texturePath='./assets/textures/xwing.png'
    @speed=2
    @scaleX,@scaleY=0.1,0.1

    super(Definitions::RES_WIDTH/2,Definitions::RES_HEIGHT-80)
  end

end
