class Question < ActiveRecord::Base
	
	belongs_to :category

	has_many :answers	

	def self.get_question_json(question_id)
		q = Question.where(id: question_id)
			.pluck(:id, :text, :correct_answer_id, :img_src, :category_id).first
			
		q_json = {}
		q_json[:id] = q[0]
		q_json[:text] = q[1]
		q_json[:correct_answer_id] = q[2]
		q_json[:img_src] = q[3]
		q_json[:category_id] =  q[4]

		answers = Answer.where(question_id: question_id).pluck(:id, :text)

		q_json[:answers] = answers.map do |a|
			a_json = {}
			a_json[:id] = a[0]
			a_json[:text] = a[1]
			a_json
		end	

		return q_json
	end
end
