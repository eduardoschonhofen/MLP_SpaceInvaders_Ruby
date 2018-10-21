require 'gosu'
require_relative "scripts/Player"
require_relative "scripts/Star"

require_relative "scripts/ZOrder"
require_relative "scripts/Shoot"
require_relative 'scripts/Enemy'
require_relative 'scripts/Blocks'
require_relative 'scripts/Aliens'

require_relative 'scripts/Collision.rb'
class Game


end


class GameWindow < Gosu::Window
  include Collision

  def initialize()

    super Definitions::RES_WIDTH, Definitions::RES_HEIGHT,false
    self.caption= "Space Invaders MLP"
    @tela_inicial = true
    @font = Gosu::Font.new(self, "assets/textures/victor-pixel.ttf", 40)
    @background_image = Gosu::Image.new("./assets/textures/goku.jpg",tileable=false)
    @player=Player.new()
    @enemy=Enemy.new()

    #@blocks= Blocks.new()
    @blocks=Array.new(20)
    @j = 0
    @conj_blocos = 3
    @dist_conj = 0
    until @j > @conj_blocos do
      @blocks[0+@j*5]=Blocks.new(100+@dist_conj,400)
      @blocks[1+@j*5]=Blocks.new(100+@dist_conj,432)
      @blocks[2+@j*5]=Blocks.new(132+@dist_conj,400)
      @blocks[3+@j*5]=Blocks.new(164+@dist_conj,400)
      @blocks[4+@j*5]=Blocks.new(164+@dist_conj,432)
      @dist_conj = @dist_conj + 175
      @j+=1
    end

    @aliens=Array.new(11)
    @k = 0
    @dist_aliens = 0
    until @k > 10 do
      @aliens[@k]=Aliens.new(75+@dist_aliens, 200)
      @dist_aliens = @dist_aliens + 60
      @k+=1
    end



    @player_shoot = nil
    #@star_anim=Gosu::Image::load_tiles(self,"./assets/textures/Star.png",25,25,tileable=false)
   # @stars=Array.new
   # @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end
  def update
    unless @tela_inicial
      if @player_shoot != nil and @enemy != nil
        if collision?(@player_shoot, @enemy)
          @enemy = nil
          @player_shoot = nil
        end
      end

      @num_blocks = 0
      until @num_blocks > 19 do
        if @player_shoot != nil and @blocks[@num_blocks] != nil
          if collision?(@player_shoot, @blocks[@num_blocks])
            @blocks[@num_blocks] = nil
            @player_shoot = nil
          end
        end
        @num_blocks+=1
      end

      @num_aliens = 0

      if(@move_left >= 100 && @move_down2 >= 21)
        @move_left = 0
        @move_right = 0
        @move_down = 0
        @move_down2 = 0
      end

      if(@move_left >= 100 && @move_down2 <= 20)
        until @num_aliens > 10 do
          @aliens[@num_aliens].MoveDown
          @num_aliens+=1
        end
        @move_down2 += 1
      end

      if @move_right < 100
        until @num_aliens > 10 do
          @aliens[@num_aliens].MoveRight
          @num_aliens+=1
        end
        @move_right += 1
      end

      if @move_right >= 100 && @move_down <= 20
        until @num_aliens > 10 do
          @aliens[@num_aliens].MoveDown
          @num_aliens+=1
        end
        @move_down+=1
      end

      if @move_right >= 20 && @move_down >= 21
        until @num_aliens > 10 do
          @aliens[@num_aliens].MoveLeft
          @num_aliens+=1
        end
        @move_left += 1
      end



      # Atualiza o tiro do player
      if @player_shoot != nil
        @player_shoot.MoveTop

        if @player_shoot.out?
          @player_shoot = nil
        end
      end

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

      @j = 0

      until @j > 19 do
        if @blocks[@j] != nil
          @blocks[@j].draw
        end
        @j+=1
      end

      @k = 0
      until @k > 10 do
        @aliens[@k].draw
        @k+=1
      end


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
end


window=GameWindow.new()
window.show
