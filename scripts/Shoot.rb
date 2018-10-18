class Shoot

  class Player



    def initialize()
      @animation=Gosu::Image::load_tiles("./assets/textures/ships.png",256,260,{})
      @image=@animation[5]
      @beep = Gosu::Sample.new("./assets/textures/Beep.wav")

      @x=@y=@vel_x=@vel_y=@angle=0.0
      @score=0
      @speed=0.15

      @RES_WIDTH=640
      @RES_HEIGTH=480
    end

    def warp(x,y)
      @x,@y=x,y
    end

    def left
      @vel_x-=@speed
    end
    def right
      @vel_x+=@speed
    end


    def move
      @x+=@vel_x
      @y+=@vel_y
      @x %=@RES_WIDTH
      @y %=@RES_HEIGTH
      @vel_x *= 0.95
      @vel_y*=0.95
    end

    def draw
      @image.draw(@x,@y,1,0.35,0.35)
    end

    def score
      @score
    end

    def collect_stars(stars)
      if stars.reject!{|star| Gosu::distance(@x,@y,star.x,star.y)<35} then
        @score+=1
        @beep.play
        true
      else
        false
      end
    end
  end
end