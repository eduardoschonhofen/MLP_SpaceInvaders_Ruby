require 'gosu'
require_relative "scripts/Player"
require_relative "scripts/Star"

require_relative "scripts/ZOrder"
require_relative "scripts/Shoot"
require_relative 'scripts/Enemy'
require_relative 'scripts/Blocks'


require_relative 'scripts/Collision'
require_relative 'scripts/GlobalCollision'
include Collision



class Game< Gosu::Window


  def initialize()

    super Definitions::RES_WIDTH, Definitions::RES_HEIGHT,false
    self.caption= "Space Invaders MLP"
    @tela_inicial = true
    @font = Gosu::Font.new(self, "assets/textures/victor-pixel.ttf", 40)
    @player=Player.new()
    @totalEnemys=30
    @totalBlocks=19

    StartBlocks()
    StartEnemys()
    @player_shoot = nil


  end

  def StartEnemys
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

  def update
    unless @tela_inicial
      Shoot_Enemy_Collision()

      Shoot_Block_Collision()

      Move_Enemys()

      Move_Player_Shoot()

      Player_Controls()
    end
    return unless @tela_inicial
    @move_down = 0
    @move_down2 = 0
    @move_left = 0
    @move_right = 0
  end

  def draw
    unless @tela_inicial
      #@background_image.draw(0,0,0)
      @player.draw

      if @enemy != nil
        @enemy.draw
      end



      draw_Blocks()

      draw_Enemys()


      if @player_shoot != nil
        @player_shoot.draw
      end
    end
    return unless @tela_inicial
      @font.draw_text("SPACE INVADERS", 50, 170, 50, 2.0, 2.0, Gosu::Color::GREEN)
      @font.draw_text("press space to play", 150, 280, 50, 1, 1, Gosu::Color::BLUE)
      @font.draw_text("MADE BY:", 50, 400, 50, 0.7, 0.7, Gosu::Color::WHITE)
      @font.draw_text("Cassiano Bruckhoff", 50, 430, 50, 0.7, 0.7, Gosu::Color::WHITE)
      @font.draw_text("Eduardo Schonhofen", 50, 460, 50, 0.7, 0.7, Gosu::Color::WHITE)
      @font.draw_text("Giovani Tirello", 50, 490, 50, 0.7, 0.7, Gosu::Color::WHITE)
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

  def draw_Enemys
    @k = 0
    until @k >= @totalEnemys do
      @enemys[@k].draw
      @k += 1
    end
  end

  def draw_Blocks
    @j = 0
    until @j > @totalBlocks do
      if @blocks[@j] != nil
        @blocks[@j].draw
      end
      @j += 1
    end
  end

  def Player_Controls
    if button_down? Gosu::KbSpace and @player_shoot == nil
      @player_shoot = Shoot.new(@player.Movement)
    end

    if button_down? Gosu::KbLeft or button_down Gosu::GpLeft then
      @player.MoveLeft
    end
    if button_down? Gosu::KbRight or button_down Gosu::GpRight then
      @player.MoveRight
    end
  end

  def Move_Player_Shoot
    if @player_shoot != nil
      @player_shoot.MoveTop

      if @player_shoot.out?
        @player_shoot = nil
      end
    end
  end

  def Move_Enemys
    @num_enemys = 0

    if (@move_left >= 100 && @move_down2 >= 21)
      @move_left = 0
      @move_right = 0
      @move_down = 0
      @move_down2 = 0
    end

    if (@move_left >= 100 && @move_down2 <= 20)
      until @num_enemys >= @totalEnemys do
        @enemys[@num_enemys].MoveDown
        @num_enemys += 1
      end
      @move_down2 += 1
    end

    if @move_right < 100
      until @num_enemys >= @totalEnemys do
        @enemys[@num_enemys].MoveRight
        @num_enemys += 1
      end
      @move_right += 1
    end

    if @move_right >= 100 && @move_down <= 20
      until @num_enemys >= @totalEnemys do
        @enemys[@num_enemys].MoveDown
        @num_enemys += 1
      end
      @move_down += 1
    end

    if @move_right >= 20 && @move_down >= 21
      until @num_enemys >= @totalEnemys do
        @enemys[@num_enemys].MoveLeft
        @num_enemys += 1
      end
      @move_left += 1
    end
  end

  def Shoot_Block_Collision
    @num_blocks = 0
    until @num_blocks > @totalBlocks do
      if @player_shoot != nil and @blocks[@num_blocks] != nil
        if collision?(@player_shoot, @blocks[@num_blocks])
          @blocks[@num_blocks] = nil
          @player_shoot = nil
        end
      end
      @num_blocks += 1
    end
  end

  def Shoot_Enemy_Collision
    @num_enemys=0

    until @num_enemys > @totalEnemys
      if @player_shoot != nil and @enemys[@num_enemys] != nil

        if collision?(@player_shoot, @enemys[@num_enemys])
          @enemys[@num_enemys] = nil
          @player_shoot = nil
        end
    end
    @num_enemys+=1
    end
  end

  def StartBlocks
    @blocks = Array.new(20)
    @j = 0
    @conj_blocos = 3
    @dist_conj = 0
    until @j > @conj_blocos do
      @blocks[0 + @j * 5] = Blocks.new(100 + @dist_conj, 400)
      @blocks[1 + @j * 5] = Blocks.new(100 + @dist_conj, 432)
      @blocks[2 + @j * 5] = Blocks.new(132 + @dist_conj, 400)
      @blocks[3 + @j * 5] = Blocks.new(164 + @dist_conj, 400)
      @blocks[4 + @j * 5] = Blocks.new(164 + @dist_conj, 432)
      @dist_conj = @dist_conj + 175
      @j += 1
    end
  end
end


window=Game.new()
window.show
