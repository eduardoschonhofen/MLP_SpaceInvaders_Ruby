class GlobalCollision
  def initialize(enemys,player,shoot_enemy,shoot_player,blocks)
    @enemys=enemys
    @player=player
    @shoot_enemy=shoot_enemy
    @shoot_player=shoot_player
    @blocks=blocks
  end


  def Shoot_to_Enemy()
    num_enemys=0
    until num_enemys > @enemys.totalEnemys
      enemy=@enemys.enemys[num_enemys]
      if @shoot_player.isAlive? and enemy.isAlive?
        if collision?(@shoot_player, enemy)
          enemy.die
          @shoot_player.die
        end
      end
      num_enemys+=1
    end
  end

end


