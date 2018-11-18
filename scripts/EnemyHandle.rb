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
    if !shoot.isAlive?
      enemy=@enemys.sample
      while enemy==nil
        enemy=@enemys.sample
      end
      enemy_shoot=EnemyShoot.new(enemy.Movement)
      return enemy_shoot
    end
  end

  def Move_Enemys
    for enemy in @enemys do
      if enemy.isAlive?
        limiteEsquerda=enemy;
        break
      end
    end
    for enemy in @enemys.reverse()
      if enemy.isAlive?
        limiteDireita=enemy;
        break
      end
    end


    if limiteEsquerda.Movement.x==0
      puts("Limite Esquerda")
      @movement=-1
    else if limiteDireita.Movement.x== Definitions::RES_WIDTH
           puts("Limite Direita")
           @movement=1
         end
    end
    if @movement==-1
      moveEsquerda
    else
    moveDireita
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