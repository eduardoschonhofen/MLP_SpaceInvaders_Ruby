
require('gosu')
require_relative 'scripts/Definitions'





Enemy=Struct.new(:posx,:posy,:alive)
Block=Struct.new(:posx,:posy,:alive)
Shoot=Struct.new(:posx,:posy,:alive,:direction)
Player=Struct.new(:posx,:posy,:alive)

class FunctionalGame< Gosu::Window

  def initialize
    super Definitions::RES_WIDTH, Definitions::RES_HEIGHT,false
    self.caption= "Space Invaders MLP Funcional"
    @totalEnemys=31
    @totalBlocks=20

    @textureEnemy =Gosu::Image.new("./assets/textures/tie.png",{})
    @texturePlayer =Gosu::Image.new("./assets/textures/xwing.png",{})
    @textureEnemyShoot =Gosu::Image.new("./assets/textures/enemyshoot.png",{})
    @texturePlayerShoot =Gosu::Image.new("./assets/textures/shoot.png",{})
    @textureBlock =Gosu::Image.new("./assets/textures/block.jpg",{})
    @textureBackground =Gosu::Image.new("./assets/textures/death_star.jpg",{})


    @enemys=startEnemysArray()
    @blocks=startBlocksArray()
    @player_shoot=startPlayerShoot()
    @enemy_shoot=startEnemyShoot()
    @player=startPlayer()

  end

  def startEnemysArray()
    enemys=geraArray(0,@totalEnemys,Enemy)
    enemys=posicionaInimigos(enemys,0)
  end

  def posicionaInimigos(enemys,i)
    if i>=3
      return Array.new()
    end
    linha=geraLinha(enemys[0..10],0,i)
    proximaLinhas=posicionaInimigos(enemys[10...-1],i+1)
    return linha + proximaLinhas
  end
  def geraLinha(enemys,i,linha)
    if i==10
      return Array.new()
    end
    enemy=Enemy.new((i+1)*60,(linha+1)*75-50,true)
    proximo=geraLinha(enemys[1..-1],i+1,linha)
    proximo.push(enemy)
  end

  def geraArray(k,total,tipo)
    if k>=total
      return Array.new()
    end
    enemy=tipo.new(0,0,true)
    nextElement=geraArray(k+1,total,tipo)
    return nextElement.push(enemy)
  end


  def posicionaBlocos(blocks,i)
    if i==4
      return Array.new()
    end
    bloco=geraBlocos(blocks[0..4],i)
    proximos=posicionaBlocos(blocks[5..-1],i+1)
    return bloco+proximos
  end

  def geraBlocos(blocks,i)
    blocks[0] = Block.new(100 + i*175, 400)
    blocks[1] = Block.new(100 + i*175, 432)
    blocks[2] = Block.new(132 + i*175, 400)
    blocks[3] = Block.new(164 + i*175, 400)
    blocks[4] = Block.new(164 + i*175, 432)
    return blocks
  end

  def startBlocksArray()
    blocks=geraArray(0,@totalBlocks,Block)
    blocks=posicionaBlocos(blocks,0)
  end
  def startPlayerShoot()
      return Shoot.new(0,0,false,-1)
  end
  def startEnemyShoot()
    return Shoot.new(0,0,false,1)

  end

  def startPlayer()
    return Player.new(Definitions::RES_WIDTH/2,Definitions::RES_HEIGHT-80,true)
  end



  def update
   # @enemys=updateEnemys(@enemys)





  end



  def draw
  drawScreen = lambda do |texture,obj,z,scaleX,scaleY|
        if obj.alive
          texture.draw(obj.posx,obj.posy,z,scaleX,scaleY)
        end
    end

    @enemys.each do |enemy|
      drawScreen.call(@textureEnemy,enemy,1,0.025,0.025)
    end

    @blocks.each do |block|
      drawScreen.call(@textureBlock,block,1,0.5,0.5)
    end

    @textureBackground.draw(1,1,0,1,1)

    drawScreen.call(@texturePlayer,@player,0,0.1,0.1)









  end




end

  window=FunctionalGame.new()
  window.show