class ReviewsController < ApplicationController
	before_action :signed_in_user

	def create
		@micropost = Micropost.find(params[:review][:post_id])

		if params[:like] == 'Like'
			current_user.upvote!(@micropost)
		elsif params[:dislike] == 'Dislike'
			current_user.downvote!(@micropost)
		end

		#redirect_to root_path
		respond_to do |format|
			format.html { redirect_to root_path }
			format.js
		end
	end

	def destroy
		@micropost = Review.find(params[:id]).post

		current_user.reset_vote!(@micropost)
		respond_to do |format|
			format.html { redirect_to root_path }
			format.js
		end

	end
end