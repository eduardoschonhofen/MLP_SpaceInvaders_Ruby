require 'gosu'
require_relative "scripts/Player"
require_relative "scripts/Star"

require_relative "scripts/ZOrder"
class Game


end


class GameWindow < Gosu::Window
  def initialize()
    super 640,480,false
    self.caption= "Space Invaders MLP"

    @background_image = Gosu::Image.new("./assets/textures/goku.jpg",tileable=false)
    @player=Player.new()
    @player.warp(320,240)

    @star_anim=Gosu::Image::load_tiles(self,"./assets/textures/Star.png",25,25,tileable=false)
    @stars=Array.new
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end
  def update

    if button_down? Gosu::KbLeft or button_down Gosu::GpLeft then
      @player.turn_left
    end
    if button_down? Gosu::KbRight or button_down Gosu::GpRight then
      @player.turn_right
    end
    if button_down? Gosu::KbUp or button_down Gosu::GpUp then
      @player.accelerate
    end
    @player.move

    @player.collect_stars(@stars)

    if rand(100)<4 and @stars.size <25 then
      @stars.push(Star.new(@star_anim))
    end

  end

  def draw

    @background_image.draw(0,0,0)
    @player.draw
    @stars.each{|star| star.draw}
    @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)

  end

  def button_down(id)
    if id==Gosu::KbEscape
      close
    end
  end
end


window=GameWindow.new()
window.show

puts "AAA"