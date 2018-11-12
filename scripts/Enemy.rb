require_relative 'Definitions'
require_relative 'Texture'
require_relative 'Movement'
require_relative 'GameObject'
class Enemy < GameObject
  attr_accessor :Movement

  def initialize(x,y)
    @texturePath='./assets/textures/tie.png'
    @speed=0.5
    @scaleX,@scaleY=0.025,0.025

    super(x,y)
  end
end