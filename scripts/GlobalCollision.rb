class GlobalCollision
  def initialize(enemys,player,blocks)
    @enemys=enemys
    @player=player
    @blocks=blocks
  end


  def Shoot_to_Enemy(shoot_player)

    num_enemys=0
    until num_enemys > @enemys.totalEnemys-1
      enemy=@enemys.enemys[num_enemys]
      if shoot_player.isAlive? and enemy.isAlive?
        if collision?(shoot_player, enemy)
          enemy.die
          shoot_player.die
        end
      end
      num_enemys+=1
    end
  end

  def Enemy_Shoot_to_Block(enemy_shoot)
    num_blocks = 0
    until num_blocks > @blocks.totalBlocks do
      block=@blocks.blocks[num_blocks]
      if enemy_shoot.isAlive? and block.isAlive?
        if collision?(enemy_shoot, block)
          block.die
          enemy_shoot.die
        end
      end
      num_blocks += 1
    end
  end
  def Enemy_Shoot_Player_Collision(enemy_shoot)
    if enemy_shoot.isAlive?
      if collision?(enemy_shoot,@player)
        enemy_shoot.die
        @gameover = true
      end
    end
  end
  def Shoot_Block_Collision(player_shoot)

    num_blocks = 0
    until num_blocks > @blocks.totalBlocks do
      block=@blocks.blocks[num_blocks]
      if player_shoot.isAlive? and block.isAlive?
        if collision?(player_shoot, block)
          block.die
          player_shoot.die
        end
      end
      num_blocks += 1
    end
  end
end


