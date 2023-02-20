# hangman game
require 'json'

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

  def guess(guess, current_answer, secret_word)
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

puts "Welcome to hangman! Guess a single letter to begin. You can have 10 wrong answers. To save, type 'save', a space 
and name of file (e.g. 'save 1'). To load, type load instead (e.g. 'load 1').
Be aware that looking inside the savefile will reveal the answer in current build."
player = Player.new
dictionary = File.open('google-10000-english-no-swears.txt')
words = dictionary.readlines

until player.secret_word.length > 5 && player.secret_word.length < 12
  player.secret_word = words[rand(words.length)].strip
end
player.current_answer = Array.new(player.secret_word.length, '_')

until player.game_over
  guess = gets.chomp.strip.downcase
  if guess.length > 1
    if guess.split(' ')[0] == 'save'
      game_state = [{'Secret_word'=>player.secret_word, 'Current_answer'=>player.current_answer, 'Wrong_answer'=>player.wrong_answers}]
      File.open("#{guess.split(' ')[1]}.json", 'w') { |f| f.puts game_state.to_json }
    end
    if guess.split(' ')[0] == 'load'
      file = File.open("#{guess.split(' ')[1]}.json", 'r')
      game_state = JSON.load(file)
      player.secret_word = game_state[0]['Secret_word']
      player.current_answer = game_state[0]['Current_answer']
      player.wrong_answers = game_state[0]['Wrong_answers']
      guess = gets.chomp.strip.downcase
    end
  end
  player.guess(guess, player.current_answer, player.secret_word)
  player.check_game_over(player.current_answer, player.secret_word)
end

player.check_victory
