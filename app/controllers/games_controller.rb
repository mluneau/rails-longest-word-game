class GamesController < ApplicationController
  def new
    @letters = (0...10).map { (65 + rand(0..25)).chr }
  end

  def score
    @word = params[:word]
  end
end
