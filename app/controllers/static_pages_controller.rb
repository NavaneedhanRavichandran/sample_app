class StaticPagesController < ApplicationController
	before_action :signed_in_user, only: [:trends]

	def home
		if signed_in?
			@micropost = current_user.microposts.build
			@feed_items = current_user.feed.paginate(page: params[:page])
		end
	end

	def trends
		if signed_in?
			@feed_items = Micropost.trend_posts.paginate(page: params[:page])
		end
	end

	def help
	end

	def about
	end

	def contact
	end
end
