class Interface

  ROLES = {
    "C" => "secret code creator",
    "B" => "secret code breaker"
  }

  VALID_ROLES = ROLES.keys

  def prompt_user
    puts "What do you want to be?\n #{ROLES.map { |pair| pair.join(' - ')}.join(' or ')}?"
    puts "Enter the letter!"
  end

  def validate_input(input)
    VALID_ROLES.detect{ |inp| inp == input}
  end

  def wrong_choice
    puts "Wrong choice, try again!"
    get_valid_input
  end

  def get_valid_input
    prompt_user
    choice = validate_input(gets.chomp.upcase) || wrong_choice
  end

  def get_role
    get_valid_input
  end

end
