
require('gosu')
require_relative 'scripts/Definitions'





Enemy=Struct.new(:posx,:posy,:alive,:speed)
Block=Struct.new(:posx,:posy,:alive,:speed)
Shoot=Struct.new(:posx,:posy,:alive,:direction)
Player=Struct.new(:posx,:posy,:alive,:speed)

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
    @direction=setRight

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
    enemy=Enemy.new((i+1)*60,(linha+1)*75-50,true,0.5)
    proximo=geraLinha(enemys[1..-1],i+1,linha)
    proximo.push(enemy)
  end

  def geraArray(k,total,tipo)
    if k>=total
      return Array.new()
    end
    enemy=tipo.new(0,0,true,0)
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
    return Player.new(Definitions::RES_WIDTH/2,Definitions::RES_HEIGHT-80,true,2)
  end



  def update
    @enemys=updateEnemys(@enemys)
    playerAction=player_Controls(@player_shoot)
    @player_shoot=movePlayerShoot(@player_shoot)
    if playerAction != nil
    @player=playerAction[0].call(@player)
    @player_shoot=playerAction[1].call(@player_shoot,@player)
    end
  end

  def updatePlayer(player)

  end
  def button_down(id)
    if id==Gosu::KbEscape
      close
    end

    return unless @tela_inicial
    if id==Gosu::KbSpace
      @tela_inicial = false
    end
  end

  private

  def movePlayerShoot(player_shoot)
    moveShoot(player_shoot).call(player_shoot)
  end


def moveShoot(shoot)
  shoot = lambda do |obj|
    if obj.alive
      tiro=Shoot.new(obj.posx,obj.posy+obj.direction,true,obj.direction)
      return tiro
    end
     return obj
  end
  end



  def player_Controls(player_shoot)
    if button_down? Gosu::KbSpace and !player_shoot.alive
      return [ident,newShoot]
    end

    if button_down? Gosu::KbLeft or button_down Gosu::GpLeft then
      return [setLeft,ident2]
    end
    if button_down? Gosu::KbRight or button_down Gosu::GpRight then
      return [setRight,ident2]
    end
  end

  def ident
    identidade = lambda do |obj|
      return obj
    end


    return identidade
  end

  def ident2
    identidade = lambda do |obj2,obj|
      return obj2
    end


    return identidade
  end
  def newShoot
    shoot = lambda do |obj2,obj|
      if obj.alive and !obj2.alive
        tiro=Shoot.new(obj.posx+15,obj.posy,true,-6)
        return tiro
      end
    end

    return shoot
  end

  def updateEnemys(enemys)
    menorEsquerda=enemys.min_by(&:posx).posx
    maiorDireita=enemys.max_by(&:posx).posx

    if menorEsquerda<=0
      @direction=setRight
      enemys.map do
      |enemy| enemy.posy=enemy.posy+10
      end

    end
    if maiorDireita+@textureEnemy.width*0.025>=Definitions::RES_WIDTH
      @direction=setLeft
      enemys.map do
        |enemy| enemy.posy=enemy.posy+10
      end
    end
    enemys.each do
      |enemy|
      @direction.call(enemy)
    end

    return enemys

  end

  def setRight
    moveRight = lambda do |obj|
      if obj.alive
        obj.posx=obj.posx+obj.speed
        return obj
      end
    end

    return moveRight
  end

  def setLeft
    moveLeft = lambda do |obj|
      if obj.alive
        obj.posx=obj.posx-obj.speed
        return obj
      end
    end

    return moveLeft
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

    @texturePlayerShoot.draw(@player_shoot.posx,@player_shoot.posy,1,0.1,0.1)

  end




end

  window=FunctionalGame.new()
  window.show