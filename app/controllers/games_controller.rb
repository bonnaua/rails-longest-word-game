require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def get_api(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt.downcase}"
    user_attempt = URI.open(url).read
    JSON.parse(user_attempt)
  end

  def score
    @attempt = params[:word].downcase
    @letters = params[:letters].gsub(/\s+/, '').downcase
    @result = "Your word \'#{@attempt}\' is not in the grid"

    if @attempt.upcase.chars.all? { |letter| @attempt.upcase.chars.count(letter) <= @letters.upcase.chars.count(letter) }
      if get_api(@attempt)["found"]
        @result = "Well done ! Your word \'#{@attempt}\' exists"
      else
        @result = "Your word \'#{@attempt}\' is not an english word"
      end
    end
  end
    #
    # p attempt
    # p letters
end
