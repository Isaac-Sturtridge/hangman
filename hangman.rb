# hangman game
class Player
  attr_accessor :letters_used, :current_answer, :wrong_answers, :secret_word, :game_over, :victory

  def initialize
    @letters_used = []
    @secret_word = 'aaaaa'
    @current_answer = []
    @wrong_answers = 0
    @game_over = false
    @victory = false
  end

  def test_guess(guess)
    if secret_word.include?(guess)
      current_answer[secret_word.index(guess)] = guess
    end
  end

  def guess
    guess = gets.chomp.strip
    if letters_used.count(guess).zero?
      letters_used.push(guess)
    end
    puts "Letters used: #{letters_used}"
    if secret_word.count(guess).zero?
      @wrong_answers += 1
    end
    test_guess(guess) while current_answer.count(guess) < secret_word.count(guess)
  end

  def check_game_over(current_answer, secret_word)
    if @wrong_answers > 10
      @game_over = true
    end
    if current_answer.join('') == secret_word
      @victory = true
      @game_over = true
    end
  end

  def check_victory
    if victory && game_over
      puts 'well done, you won!'
    else
      puts 'bad luck!'
    end
  end
end

player = Player.new
player.guess
dictionary = File.open('google-10000-english-no-swears.txt')
words = dictionary.readlines

until player.secret_word.length > 5 && player.secret_word.length < 12
  player.secret_word = words[rand(words.length)].strip
end
player.current_answer = Array.new(player.secret_word.length, '_')

until player.game_over
  player.guess
  puts player.current_answer.join(' ')
  player.check_game_over(player.current_answer, player.secret_word)
end

player.check_victory
