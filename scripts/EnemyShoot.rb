require_relative 'Shoot'
class EnemyShoot<Shoot

  def initialize(movement)
    @texturePath='./assets/textures/enemyshoot.png'
    @Texture = Texture.new(@texturePath, 0.1, 0.1)

    @speed,@x,@y= 6, movement.x+15  ,movement.y
    @width, @height = @Texture.texture.width,@Texture.texture.height
    @Movement=Movement.new(@speed, @x, @y, @width*0.1, @height*0.1)
  end
end