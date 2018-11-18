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
require_relative 'scripts/BlockHandle'
include Collision



class Game< Gosu::Window


  def initialize()

    super Definitions::RES_WIDTH, Definitions::RES_HEIGHT,false
    self.caption= "Space Invaders MLP"
    @tela_inicial = true
    @gameover = false
    @font = Gosu::Font.new(self, "assets/textures/victor-pixel.ttf", 40)
    @soundtrack=Gosu::Song.new("assets/audios/soundtrack.ogg")
    @soundtrack.volume=0.2
    @soundtrack.play(true)


    @player=Player.new()
    @background=Background.new()
    @blocks=BlockHandle.new()
    @enemys=EnemyHandle.new()
    @player_shoot = Shoot.new(nil,false)
    @enemy_shoot = EnemyShoot.new(nil,false)
    @global_collision=GlobalCollision.new(@enemys,@player,@blocks)

  end



  def update
    unless @tela_inicial || @gameover
      @global_collision.Shoot_to_Enemy(@player_shoot)
      @global_collision.Enemy_Shoot_to_Block(@enemy_shoot)
      @global_collision.Shoot_Block_Collision(@player_shoot)
      @global_collision.Enemy_Shoot_Player_Collision(@enemy_shoot)



      @enemys.Move_Enemys()
      @player_shoot.move()
      @enemy_shoot.move()

      Player_Controls()
      @enemy_shoot=@enemys.Enemy_Attack(@enemy_shoot)

    end
    return unless @tela_inicial
    @move_down = 0
    @move_down2 = 0
    @move_left = 0
    @move_right = 0


  rescue
    @gameover=true
  end

  def draw
    unless @tela_inicial || @gameover
      #@background_image.draw(0,0,0)
      @player.draw
      @blocks.draw_Blocks()
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





  def Player_Controls
    if button_down? Gosu::KbSpace and !@player_shoot.isAlive?
      @player_shoot = Shoot.new(@player.Movement)
    end

    if button_down? Gosu::KbLeft or button_down Gosu::GpLeft then
      @player.moveLeft
    end
    if button_down? Gosu::KbRight or button_down Gosu::GpRight then
      @player.moveRight
    end
  end

  def Move_Player_Shoot
    if @player_shoot.isAlive?
      @player_shoot.moveDown

      if @player_shoot.out?
        @player_shoot.die
      end
    end
  end

end


window=Game.new()
window.show
