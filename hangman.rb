# hangman game

# player class
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

  def guess(current_answer, secret_word)
    guess = gets.chomp.strip.downcase
    if guess.length == 1
      @letters_used.push(guess) if @letters_used.count(guess).zero?
      puts "Letters used: #{letters_used}"
      @wrong_answers += 1 if secret_word.count(guess).zero?
      puts "Wrong answers: #{wrong_answers}"
      secret_word.split('').each_with_index {|letter, i|
        current_answer[i] = guess if letter == guess
      }
      puts current_answer.join(' ')
    end
  end

  def check_game_over(current_answer, secret_word)
    @game_over = true if @wrong_answers > 10
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
dictionary = File.open('google-10000-english-no-swears.txt')
words = dictionary.readlines

until player.secret_word.length > 5 && player.secret_word.length < 12
  player.secret_word = words[rand(words.length)].strip
end
player.current_answer = Array.new(player.secret_word.length, '_')

until player.game_over
  player.guess(player.current_answer, player.secret_word)
  player.check_game_over(player.current_answer, player.secret_word)
end

player.check_victory
