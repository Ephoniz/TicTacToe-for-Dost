class MovesController < ApplicationController
    def create
        @game = Game.find(params[:game_id])
        @game.move!(params[:row], params[:col])
        @winner = @game.checkwinner
        p @winner
        respond_to do |format|
          format.turbo_stream
          format.html {
            redirect_to @game
          }
        end
    end
end
