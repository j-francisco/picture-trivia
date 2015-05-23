class SessionsController < ApplicationController
	
	def login
		email = params[:email]
		
		u = User.where(email: email).pluck(:id, :email, :username).first
		# u = User.where(email: email).first
		user = {id: u[0], email: u[1], username: u[2]}
		if u.present?
			render json: user.to_json
			return
		else
			head :forbidden
			return
		end
	end
end