class QuestionsController < ApplicationController

	def index

	end

	def new
		@question = Question.new

		@categories = Category.pluck(:id, :name)
	end

	def create
		@validation_errors = []

		if params[:question][:img_src].blank?
			@validation_errors << "Missing image source"
		end

		if params[:text].blank?
			@validation_errors << "Missing question text"
		end

		if params[:correct_answer].blank? || !(["1", "2", "3", "4"].include?(params[:correct_answer]))
			@validation_errors << "Missing correct answer"
		end

		if params[:category].blank? || (params[:category] == "0" && params[:new_category].blank?)
			@validation_errors << "Missing category"
		end

		if params[:answer1].blank? || params[:answer2].blank? || params[:answer3].blank? || params[:answer4].blank?
			@validation_errors << "Answers are missing"
		end

		if !@validation_errors.empty?
			respond_to do |format|
				format.json { render json: @validation_errors, status: :unprocessable_entity }
				return
			end
		end

		cloudinary_result = Cloudinary::Uploader.upload(params[:question][:img_src])

		answer1 = Answer.new 
		answer1.text = params[:answer1]
		answer1.save
		correct_answer_id = answer1.id if params[:correct_answer] == "1"

		answer2 = Answer.new 
		answer2.text = params[:answer2]
		answer2.save
		correct_answer_id = answer2.id if params[:correct_answer] == "2"

		answer3 = Answer.new 
		answer3.text = params[:answer3]
		answer3.save
		correct_answer_id = answer3.id if params[:correct_answer] == "3"

		answer4 = Answer.new 
		answer4.text = params[:answer4]
		answer4.save
		correct_answer_id = answer4.id if params[:correct_answer] == "4"

		if params[:category] == "0"
			category = Category.new
			category.name = params[:new_category]
			category.save
			category_id = category.id
		else
			category_id = params[:category].to_i
		end

		@question = Question.new
		@question.text = params[:text]
		@question.correct_answer_id = correct_answer_id
		@question.category_id = category_id
		@question.img_src = cloudinary_result["secure_url"]
		@question.img_public_id = cloudinary_result["public_id"]

		saved = @question.save

		if saved
			answer1.question_id = @question.id
			answer1.save
			answer2.question_id = @question.id
			answer2.save
			answer3.question_id = @question.id
			answer3.save
			answer4.question_id = @question.id
			answer4.save
		end

		respond_to do |format|
			if saved
				format.html { redirect_to @question, notice: 'Question was successfully created.' }
				format.json { render :show, status: :created, location: @question }
			else
				format.html { render :new }
				format.json { render json: @question.errors, status: :unprocessable_entity }
			end
		end
	end

	def show
		@question = Question.find(params[:id].to_i)
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_question
		@question = Question.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	# def question_params
	# 	params.require(:question).permit(:text, :last_name)
	# end
end