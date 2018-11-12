require_relative 'Definitions'
require_relative 'Texture'
require_relative 'Movement'
require_relative 'GameObject'
class Blocks < GameObject
  attr_accessor :Movement

  def initialize(x,y)
    @texturePath='./assets/textures/block.jpg'
    @scaleX,@scaleY=0.5,0.5
    super(x,y)
  end



end