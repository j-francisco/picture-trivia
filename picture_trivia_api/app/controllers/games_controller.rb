class GamesController < ApplicationController

	def new
		category_name = params[:category_name]

		if category_name.blank?
			render json: {errors: "Missing Category to create Game"}, status: 422
			return
		end

		# if game_type blank, use default for now
		game_type = params[:game_type]

		user_id = params[:user_id]

		if user_id.blank?
			render json: {errors: "Missing User ID to create Game"}, status: 422
			return
		end

		game = Game.new
		game.name = "Game name"
		game.category_id = Category.where(name: category_name).pluck(:id).first

		if game.category_id.nil?
			render json: {errors: "Invalid Category for creating Game"}, status: 422
			return
		end

		game.question_count = 3

		if game.save
			game_json = game.as_json

			ug = UserGame.new
			ug.user_id = user_id
			ug.game_id = game.id
			
			if ug.save
				game_json["user_game_id"] = ug.id
				render json: game_json
				return
			else
				render json: {errors: ug.errors.full_messages}, status: 422
				return
			end
		else
			render json: {errors: game.errors.full_messages}, status: 422
			return
		end

		
	end

	def view
		game = Game
			.joins(:category)
			.where(id: params[:id].to_i)
			.select("games.*, categories.name AS category_name")
			.select_all.first

		render json: game
	end
end