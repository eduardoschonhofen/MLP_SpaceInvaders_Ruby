class EnemyHandle
  attr_accessor :totalEnemys, :enemys
  def initialize()
    @movement=1
    @totalEnemys=30
    startEnemys
  end

  def startEnemys
    @enemys = Array.new(@totalEnemys)
    @k = 0
    y=-50
    @dist_enemys = 0
    until @k >= @totalEnemys do
      if((@k)%10==0)
        y=y+75
        @dist_enemys=0
      end
      @enemys[@k] = Enemy.new(75 + @dist_enemys, y)
      @dist_enemys = @dist_enemys + 60
      @k += 1
    end
  end


  def Enemy_Attack(shoot)
    if  !shoot.isAlive?
      enemy=@enemys.sample
      while !enemy.isAlive?
        enemy=@enemys.sample
      end
      enemy_shoot=EnemyShoot.new(enemy.Movement)
      return enemy_shoot
    end
    return shoot
  end

  def Move_Enemys
    limiteEsquerda,limiteDireita=Definitions::RES_WIDTH,0
    for enemy in @enemys do
      if enemy.isAlive? and enemy.Movement.x < limiteEsquerda
        limiteEsquerda=enemy.Movement.x;
        end
        if enemy.isAlive? and enemy.Movement.x > limiteDireita
          limiteDireita=enemy.Movement.x;
      end
      end


  p

    if limiteEsquerda<=0
      puts("Limite Esquerda")
      @movement=1
      moveBaixo
    else if limiteDireita+@enemys[1].Movement.width>= Definitions::RES_WIDTH
           puts("Limite Direita")
           @movement=-1
           moveBaixo
         end
    end
    if @movement==-1
      moveEsquerda
    else
    moveDireita
      end

  end
  def moveBaixo
    for enemy in @enemys
      for i in 0..10
      enemy.MoveDown
      end
      end
  end
  def moveEsquerda
    for enemy in @enemys
      enemy.MoveLeft
    end
  end
  def moveDireita

    for enemy in @enemys
      enemy.MoveRight
    end
  end


  def draw_Enemys
    k = 0
    until k >= @totalEnemys do
      if @enemys[k]!= nil
        @enemys[k].draw
      end
      k += 1
    end
  end
  
end