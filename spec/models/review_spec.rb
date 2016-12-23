require 'spec_helper'

describe Review do
	let(:user) { FactoryGirl.create(:user) }
	let(:other_user) { FactoryGirl.create(:user) }

	let(:micropost) { FactoryGirl.create(:micropost, user: other_user, content: "Test content") }
	
	let(:review) { user.reviews.build(post_id: micropost.id) }

	
	subject { review }

	it { should be_valid }

	describe "methods" do
		it { should respond_to(:post) }
		its(:post) { should eq micropost }

		it { should respond_to(:reviewer) }
		its(:reviewer) { should eq user }
	end

	describe "when user id is not present" do
		before { review.reviewer_id = nil }
		it { should_not be_valid}
	end

	describe "when post id is not present" do
		before { review.post_id = nil }
		it { should_not be_valid }
	end
end
