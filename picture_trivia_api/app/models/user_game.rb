class UserGame < ActiveRecord::Base
	
	def add_user_answer(question_id, selected_answer_id, is_finished)
		game_question_ids = Game.where(id: self.game_id).pluck(:question_ids).first

		if !game_question_ids.include?(question_id)
			throw "Invalid Question for this Game. question_id: #{question_id}, user_game_id: #{self.id}"
			return
		end

		correct_answer_id = Question.where(id: question_id).pluck(:correct_answer_id).first

		is_correct = correct_answer_id == selected_answer_id
		
		ua = UserAnswer.new
		ua.user_game_id = self.id
		ua.selected_answer_id = selected_answer_id
		ua.is_correct = is_correct

		if ua.save
			if is_correct
				# todo - create a scoring system
				current_score = self.score || 0

				self.score = current_score + 1
			end

			self.finished_at = Time.now if is_finished

			self.save if self.changed?
		end

		return ua
	end  
end
