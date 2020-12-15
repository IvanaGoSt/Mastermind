require_relative "board"

class Codebreaker
  include Pegs

  attr_reader :secret_code, :guess_pegs, :codebreaker, :container_for_guesses, :possible_guesses

  def initialize(role)
    @role = role
    @secret_code = []
    @guess_pegs = []
    @container_for_guesses = []
    @possible_guesses = []
    @codebreaker = self.is_codebreaker?
    @i = 0
  end

  def is_codebreaker?
    @role == "B"? true : false
  end

  def get_human_input
    input = gets.chomp.chars
    while input.any?{ |x| !COLORED_PEGS.include?(x) } || input.size != 4
      puts "Wrong input, try again!"
      input = gets.chomp.chars
    end
    return input
  end

  def get_computer_try # (reds, whites)
    if @container_for_guesses.size < 4
      check_every_color
    else
      permute_guesses
    end
  end

  def check_every_color
    i = @i
    try = [COLORED_PEGS[i], COLORED_PEGS[i], COLORED_PEGS[i], COLORED_PEGS[i]]
    count_of_i = @secret_code.count(COLORED_PEGS[i])
    @container_for_guesses += try.take(count_of_i)
    @i += 1
    return try
  end


  def permute_guesses
    @possible_guesses += @container_for_guesses.permutation.to_a.sort.uniq
    @possible_guesses.shift
  end

  def breaking_code
    if codebreaker
      @guess_pegs << get_human_input
    else
      @guess_pegs << get_computer_try
    end
    @guess_pegs[-1]
  end

  def get_secret_code
    puts "Let's play!"
    if !codebreaker
      puts "Give us the code to break!"
      @secret_code = get_human_input
    else
      @secret_code = [COLORED_PEGS.sample, COLORED_PEGS.sample, COLORED_PEGS.sample, COLORED_PEGS.sample]
      puts "Enter your combination of four colors!"
    end
  end

end
