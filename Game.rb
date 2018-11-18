require 'gosu'
require_relative "scripts/Player"
require_relative "scripts/Shoot"
require_relative 'scripts/Enemy'
require_relative 'scripts/Blocks'


require_relative 'scripts/Collision'
require_relative 'scripts/GlobalCollision'
require_relative 'scripts/EnemyShoot'
require_relative 'scripts/Background'
require_relative 'scripts/EnemyHandle'
include Collision



class Game< Gosu::Window


  def initialize()

    super Definitions::RES_WIDTH, Definitions::RES_HEIGHT,false
    self.caption= "Space Invaders MLP"
    @tela_inicial = true
    @gameover = false
    @font = Gosu::Font.new(self, "assets/textures/victor-pixel.ttf", 40)
    @player=Player.new()
    @background=Background.new()
    @totalBlocks=19

    StartBlocks()

    @enemys=EnemyHandle.new()

    @player_shoot = Shoot.new(nil,false)
    @enemy_shoot = EnemyShoot.new(nil,false)
    @soundtrack=Gosu::Song.new("assets/audios/soundtrack.ogg")
    @soundtrack.volume=0.2
    @soundtrack.play(true)
    @global_collision=GlobalCollision.new(@enemys,@player,@blocks)

  end



  def update
    unless @tela_inicial || @gameover
      @global_collision.Shoot_to_Enemy(@player_shoot)

      Shoot_Block_Collision()

    #  Enemy_Shoot_Block_Collision()
     # Enemy_Shoot_Player_Collision()

      @enemys.Move_Enemys()

      Move_Player_Shoot()

      Move_Enemy_Shoot()

      Player_Controls()

      @enemy_shoot=@enemys.Enemy_Attack(@enemy_shoot)

    end
    return unless @tela_inicial
    @move_down = 0
    @move_down2 = 0
    @move_left = 0
    @move_right = 0
  end

  def draw
    unless @tela_inicial || @gameover
      #@background_image.draw(0,0,0)
      @player.draw
      draw_Blocks()
      @enemys.draw_Enemys()
      @background.draw()
      @player_shoot.draw
      @enemy_shoot.draw



    end

    return unless @tela_inicial || @gameover
    if @tela_inicial
      @font.draw_text("SPACE INVADERS", 50, 170, 50, 2.0, 2.0, Gosu::Color::GREEN)
      @font.draw_text("press space to play", 150, 280, 50, 1, 1, Gosu::Color::BLUE)
      @font.draw_text("MADE BY:", 50, 400, 50, 0.7, 0.7, Gosu::Color::WHITE)
      @font.draw_text("Cassiano Bruckhoff", 50, 430, 50, 0.7, 0.7, Gosu::Color::WHITE)
      @font.draw_text("Eduardo Schonhofen", 50, 460, 50, 0.7, 0.7, Gosu::Color::WHITE)
      @font.draw_text("Giovani Tirello", 50, 490, 50, 0.7, 0.7, Gosu::Color::WHITE)
    end
    if @gameover
      @font.draw_text("GAME OVER", 50, 170, 50, 3.0, 3.0, Gosu::Color::GREEN)
      @font.draw_text("press esc to exit", 170, 280, 50, 1, 1, Gosu::Color::BLUE)
    end
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
    if button_down? Gosu::KbSpace and @player_shoot.isAlive?
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
    if @player_shoot.isAlive?
      @player_shoot.MoveTop

      if @player_shoot.out?
        @player_shoot.die
      end
    end
  end

  def Move_Enemy_Shoot()
    if @enemy_shoot!=nil and @enemy_shoot.isAlive?
      @enemy_shoot.MoveDown

      if @enemy_shoot.out?
        @enemy_shoot.die
      end
    end
  end



  def Enemy_Shoot_Block_Collision()
    @num_blocks = 0
    until @num_blocks > @totalBlocks do
      if @enemy_shoot.isAlive? and @blocks[@num_blocks] != nil
        if collision?(@enemy_shoot, @blocks[@num_blocks])
          @blocks[@num_blocks] = nil
          @enemy_shoot.die
        end
      end
      @num_blocks += 1
    end
  end
  def Enemy_Shoot_Player_Collision()
    if @enemy_shoot.isAlive?
      if collision?(@enemy_shoot,@player)
        @enemy_shoot.die
        @gameover = true
      end
    end
  end
  def Shoot_Block_Collision
    @num_blocks = 0
    until @num_blocks > @totalBlocks do
      if @player_shoot.isAlive? and @blocks[@num_blocks] != nil
        if collision?(@player_shoot, @blocks[@num_blocks])
          @blocks[@num_blocks] = nil
          @player_shoot.die
        end
      end
      @num_blocks += 1
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
