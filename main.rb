require_relative "interface"
require_relative "codebreaker"
require_relative "board"

class Mastermind

  def initialize
    puts "Wellcome to simple command line game Mastermind!"
    puts "Six numbers (1-6) represent six colors."
    puts"The player have 12 turns to guess the secret code of four colors."

    @interface = Interface.new
    @codebreaker = Codebreaker.new(@interface.get_role)
    @board = Board.new
    @counter = 1
  end


  def playing
    @codebreaker.get_secret_code
    secret_code = @codebreaker.secret_code
    12.times do
      puts ""
      puts "Try no #{@counter}:"
      @board.populate_board(@codebreaker.secret_code, @codebreaker.breaking_code)
      puts @board.board_lines
      @counter += 1
      sleep(1)
    end
    puts ""
    puts "Sorry! This is the secret code!"
    puts @board.color_input(secret_code)
    puts ""
  end

end

Mastermind.new.playing
