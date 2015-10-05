require "./spec_helper"

describe PostsByMonth do
  
  Spec.before_each do
    Post.clear
      post = Post.new
      post.name = "Test Post"
      post.save
      post = Post.new
      post.name = "Test Post 2"
      post.save
  end

  describe "#all_by_month" do
    it "should return the number of posts per month" do
      postsbymonth = PostsByMonth.all_by_month
      postsbymonth.size.should eq 1
      postsbymonth[0].count.should eq 2
    end
  end
end

