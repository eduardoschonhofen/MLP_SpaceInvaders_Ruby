class EnemyHandle
  def initialize()
    @totalEnemys=30
    StartEnemys
  end

  def StartEnemys
    @enemys = Array.new(@totalEnemys/10)
    line=Array.new(10)

    k = 0
    i=0
    y=-50
    dist_enemys = 0

    until k >= @totalEnemys/10 do
      until i>10 do
        line[i] = Enemy.new(75 + dist_enemys, y)
        dist_enemys = dist_enemys + 60
        i+= 1
      if((i)%10==0)
        y=y+75
        dist_enemys=0
        enemys[k]=line
        line=Array.new(10)
        k+=1
      end
      end
    end
  end

  def Attack()
    if !@enemy_shoot.isAlive?
      enemy=@enemys.sample
      while enemy==nil
        enemy=@enemys.sample
      end
      @enemy_shoot=EnemyShoot.new(enemy.Movement)
    end
  end
  
end