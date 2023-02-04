# hangman game
class Player
  attr_accessor :letters_used, :current_answer, :wrong_answers
  attr_reader :secret_word, :game_over, :victory

  def initialize
    @letters_used = []
    @secret_word = 'aaaaa'
    @current_answer = Array.new(size=secret_word.length, default='_')
    @wrong_answers = 0
    @game_over = false
    @victory = false
  end

  def guess
    guess = gets.chomp
    letters_used.push(guess)
    puts "Letters used: #{letters_used}"
    if secret_word.count(guess).zero?
      wrong_answers += 1
    end
    test_guess(guess) while current_answer.count(guess) < secret_word.count(guess)
  end 

  def test_guess(guess)
    if secret_word.include?(guess)
      current_answer[secret_word.index(guess)] = guess
    end
  end

  def game_over(wrong_answers, current_answer, secret_word)
    if wrong_answers > 10
      game_over = true
    end
    if current_answer == secret_word
      victory = true
      game_over = true
    end 
  end

  def victory
    if victory && game_over
      puts "well done, you won!"
    end
  end
end

player = Player.new
player.guess
dictionary = File.open('google-10000-english-no-swears.txt')

until secret_word.length > 5 && secret_word.length < 12 
  secret_word = dictionary[rand(10_000)]
end

until game_over
  player.guess
  puts player.current_answer
end