class Micropost < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :content, presence: true, length: { maximum: 140 }

	has_many :votes, foreign_key: "post_id", class_name: "Review", dependent: :destroy
	has_many :user_votes, through: :reviews, source: :reviewer

	def self.from_users_followed_by(user)
    	followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    	where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id).order('created_at DESC')
	end

	def self.trend_posts
		#voted_post_ids = "SELECT post_id FROM reviews GROUP BY post_id HAVING sum(vote) <> 0)"
		#where("id IN (#{voted_post_ids})")
		
		temp_hash = {}
		Micropost.find_each do |post|
			temp_hash[post] = post.votes.between_dates(Date.today, Time.now).sum(:vote)
		end

		temp_hash.delete_if { |key, value| value == 0 }

		required_posts = temp_hash.sort_by { |key, value| value }.reverse

		ordered_posts = []
		required_posts.each do |post|
			ordered_posts.push(post[0])
		end

		ordered_posts
	end
end
