class Review < ActiveRecord::Base
	belongs_to :post, class_name: "Micropost"
	belongs_to :reviewer, class_name: "User"

	validates :reviewer_id, presence: true
	validates :post_id, presence: true

	scope :between_dates, ->(begin_date,end_date) {
		where("updated_at between ? and ?", begin_date, end_date)
	}
end
