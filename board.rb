module Pegs
  COLORED_PEGS = ("1".."6").to_a
  HINT_PEG = "\u23FA".center(2)

  def give_hint(secret, guess)
    # Knuth's suggestion
    pegs = {:reds => 0, :whites => 0}
    count_reds_and_whites = []
    # red pegs
    for i in (0..3)
      if guess[i] == secret[i]
        pegs[:reds] += 1
      end
    end
    # red + white pegs
    COLORED_PEGS.each do |i|
      count_reds_and_whites << [secret.count(i), guess.count(i)].min
    end
    # white pegs
    pegs[:whites] = count_reds_and_whites.inject(:+) - pegs[:reds]
    pegs
  end
end

class Board
  include Pegs

  attr_reader :board_lines

  def initialize
    @board_lines = ""
  end

  def color_input(peg)
    peg.map{|i| self.color_peg(i)}.join
  end

  def populate_board(secret, guess)
    @board_lines << color_input(guess).ljust(53, "_")
    pegs = self.give_hint(secret, guess)
    pegs[:reds].times do
      @board_lines << HINT_PEG.red
    end
    pegs[:whites].times do
      @board_lines << HINT_PEG
    end
    @board_lines << "\n"
    if guess == secret
      end_game
    end
  end

  def end_game
      puts @board_lines
      puts ""
      puts "Bravo! This is the secret code!"
      puts ""
      exit
  end

  def color_peg(peg)
    case peg
      when "1"
        peg.red.center(12)
      when "2"
        peg.green.center(12)
      when "3"
        peg.yellow.center(12)
      when "4"
        peg.blue.center(12)
      when "5"
        peg.magenta.center(12)
      when "6"
        peg.cyan.center(12)
      end
  end

end

class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(93)
  end

  def blue
    colorize(94)
  end

  def magenta
    colorize(95)
  end

  def cyan
    colorize(96)
  end

end
