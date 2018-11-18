class GlobalCollision
  def initialize(enemys,player,blocks)
    @enemys=enemys
    @player=player

    @blocks=blocks
  end


  def Shoot_to_Enemy(shoot_player)
    num_enemys=0
    until num_enemys > @enemys.totalEnemys
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

end


