require 'gosu'
require_relative "scripts/Player"
require_relative "scripts/Star"

require_relative "scripts/ZOrder"
require_relative "scripts/Shoot"
require_relative 'scripts/Enemy'

require_relative 'scripts/Collision.rb'
class Game


end


class GameWindow < Gosu::Window
  include Collision

  def initialize()

    super Definitions::RES_WIDTH, Definitions::RES_HEIGHT,false
    self.caption= "Space Invaders MLP"

    @background_image = Gosu::Image.new("./assets/textures/goku.jpg",tileable=false)
    @player=Player.new()
    @enemy=Enemy.new()
    @player_shoot = nil
    #@star_anim=Gosu::Image::load_tiles(self,"./assets/textures/Star.png",25,25,tileable=false)
   # @stars=Array.new
   # @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end
  def update
    if @player_shoot != nil and @enemy != nil
      if collision?(@player_shoot, @enemy)
        @enemy = nil
        @player_shoot = nil
      end
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

  def draw

    #@background_image.draw(0,0,0)
    @player.draw

    if @enemy != nil
      @enemy.draw
    end

    if @player_shoot != nil
      @player_shoot.draw
    end

  end

  def button_down(id)
    if id==Gosu::KbEscape
      close
    end
  end
end


window=GameWindow.new()
window.show
