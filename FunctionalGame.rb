
require('gosu')
require_relative 'scripts/Definitions'
Enemy=Struct.new(:posx,:posy,:alive)

class FunctionalGame< Gosu::Window

  def initialize
    super Definitions::RES_WIDTH, Definitions::RES_HEIGHT,false
    self.caption= "Space Invaders MLP Funcional"
    @totalEnemys=30
    @totalBlocks=19


    @enemys=startEnemysArray()
   # @blocks=startBlocksArray()
   # @player_shoot=startPlayerShoot()
   # @enemy_shoot=startEnemyShoot()

    


  end

  def startEnemysArray()
    enemys=geraArray(nil,0)
  end

  def geraArray(,k)
    if k>=@totalEnemys
      return Array.new()
    end
    enemy=Enemy.new(0,0,true)
    nextElement=geraArray(,k+1)
    return nextElement.push(enemy)
  end


  def startBlocksArray()

  end
  def startPlayerShoot()

  end
  def startEnemyShoot()

  end



  def update
   # @enemys=updateEnemys(@enemys)





  end



  def draw


  end

end

  window=FunctionalGame.new()
  window.show