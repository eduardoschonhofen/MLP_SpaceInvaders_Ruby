
require_relative 'Texture'

class Background


  def initialize()
    @texturePath='./assets/textures/death_star.jpg'
    @Texture = Texture.new(@texturePath,1,1,)
  end



  def draw
    @Texture.drawBackground(-100,0)
  end

end