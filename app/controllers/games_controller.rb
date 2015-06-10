class GamesController < ApplicationController

	def index
		@game = Game.new
		@games = Game.all
	end

	def bowl
		@game = Game.new
	end

	def create
		@action = Game.new
		@action.bowl
		redirect_to root_path
	end
end
