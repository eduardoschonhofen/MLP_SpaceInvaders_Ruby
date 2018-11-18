class GlobalCollision
  def initialize(enemys,player,blocks)
    @enemys=enemys
    @player=player
    @blocks=blocks
  end

  def Shoot_to_Enemy(shoot_player)
    threads = []

    @enemys.enemys.each do |enemy|
      threads << Thread.new() {
      if shoot_player.isAlive? and enemy.isAlive?
        if collision?(shoot_player, enemy)
          enemy.die
          shoot_player.die
        end
      end
    }
    end

    threads.each do |thread|
      thread.join
    end
  end

  def Enemy_Shoot_to_Block(enemy_shoot)
    threads = []

    @blocks.blocks.each do |block|
      threads << Thread.new() {
      if enemy_shoot.isAlive? and block.isAlive?
        if collision?(enemy_shoot, block)
          block.die
          enemy_shoot.die
        end
      end
    }
    end

    threads.each do |thread|
      thread.join
    end
  end

  def Shoot_Block_Collision(player_shoot)
    threads = []

    @blocks.blocks.each do |block|
      threads << Thread.new() {
      if player_shoot.isAlive? and block.isAlive?
        if collision?(player_shoot, block)
          block.die
          player_shoot.die
        end
      end
    }
    end

    threads.each do |thread|
      thread.join
    end
  end

  def Enemy_Shoot_Player_Collision(enemy_shoot)
    if enemy_shoot.isAlive?
      if collision?(enemy_shoot,@player)
        enemy_shoot.die
        @gameover = true
        raise
      end
    end
  end
end
