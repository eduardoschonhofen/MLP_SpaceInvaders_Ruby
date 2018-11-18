class BlockHandle
  attr_accessor :totalBlocks,:conj_blocks,:blocks
  def initialize()
    @movement=1
    @totalBlocks=19
    @conj_blocks=3
    startBlocks
  end


  def startBlocks
    @blocks = Array.new(@totalBlocks)
    j = 0
    conj_blocos = @conj_blocks
    dist_conj = 0
    until j > conj_blocos do
      @blocks[0 + j * 5] = Blocks.new(100 + dist_conj, 400)
      @blocks[1 + j * 5] = Blocks.new(100 + dist_conj, 432)
      @blocks[2 + j * 5] = Blocks.new(132 + dist_conj, 400)
      @blocks[3 + j * 5] = Blocks.new(164 + dist_conj, 400)
      @blocks[4 + j * 5] = Blocks.new(164 + dist_conj, 432)
      dist_conj = dist_conj + 175
      j += 1
    end
  end

  def draw_Blocks
    j = 0
    until j > @totalBlocks do
      if @blocks[j].isAlive?
        @blocks[j].draw
      end
      j += 1
    end
  end




end