class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @winner = @game.checkwinner
  end

  def create
    redirect_to Game.create
  end
end
