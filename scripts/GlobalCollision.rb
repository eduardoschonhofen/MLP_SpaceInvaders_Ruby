class GlobalCollision
  def Shoot_to_Enemy(player_shoot,enemy)
    if @player_shoot != nil and @enemy != nil
      if collision?(@player_shoot, @enemy)
        return true
      else
        return false
     end
    end
  end

end