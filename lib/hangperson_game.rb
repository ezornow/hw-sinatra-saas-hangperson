class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  
  def initialize(word)
    @word = word
    @guesses=""
    @wrong_guesses=""
  end
  
  def word
    @word
  end
  
  def word=(new_word)
    @word=new_word
  end
  
  def guesses
    @guesses
  end
  
  def wrong_guesses
    @wrong_guesses
  end
  
  def guess(attempt)
    attempt='' if attempt.nil?
    invalid = ((/[a-zA-z]/=~attempt)==nil)
    uppercase = /[A-Z]/=~attempt
    correct = @word.include? (attempt)
    repeat = (@guesses.include? attempt) || (@wrong_guesses.include? attempt)
    if (invalid)
      raise ArgumentError
    elsif uppercase != nil
      false
    elsif repeat
      false
    elsif correct
      @guesses=@guesses+attempt
    else
      @wrong_guesses=@wrong_guesses+attempt
    end
  end
  
  def word_with_guesses
    display_word=""
    @word.each_char do |x|
      if (@guesses.include? x)
        display_word=display_word+x
      else
        display_word=display_word+"-"
      end
    end 
    return display_word
  end
  
  def check_win_or_lose
    if self.word_with_guesses==word
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end
  

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
