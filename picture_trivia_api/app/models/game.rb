class Game < ActiveRecord::Base
	belongs_to :category

	before_create :add_questions

	def add_questions
		question_ids = Question.where(category_id: self.category_id)
			.order("random()").limit(self.question_count).pluck(:id)

		if question_ids.count < self.question_count
			self.question_count = question_ids.count
		end

		self.question_ids = question_ids
	end  

	def as_json
		game_json = {}
		game_json["id"] = self.id
		game_json["name"] = self.name
		game_json["game_type"] = self.game_type
		game_json["category_name"] = Category.where(id: self.category_id).pluck(:name)
		game_json["questions"] = self.question_ids.map do |q_id|
			Question.get_question_json(q_id)
		end

		return game_json
	end
end
