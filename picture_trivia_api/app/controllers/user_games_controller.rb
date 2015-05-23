class UserGamesController < ApplicationController
	def answer
		user_game_id = params[:user_game_id].to_i
		user_id = params[:user_id].to_i
		question_id = params[:question_id].to_i
		selected_answer_id = params[:selected_answer_id].to_i
		is_finished = params[:is_finished].downcase == "true"
		
		user_game = UserGame.find(user_game_id)

		if user_game.user_id != user_id
			throw "Invalid User for this Game. user_game_id: #{user_game_id}, user_id: #{user_id}"
			render json: {errors: "Invalid User for this Game."}, status: 422
			return
		end

		begin
			user_answer = user_game.add_user_answer(question_id, selected_answer_id, is_finished)

			if user_answer && user_answer.errors.full_messages.empty?
				render json: {success: true}
				return
			else
				render json: {errors: user_answer.errors.full_messages}, status: 422
				return
			end
		rescue Exception => e
			render json: {errors: e.message}, status: 422
			return
		end
	end
end