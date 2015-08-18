require "./spec_helper"

describe Post do
  
  Spec.before_each do
    Post.clear
  end

  it "should find all the posts" do
    post = Post.new
    post.name = "Test Post"
    post.save
    post = Post.new
    post.name = "Test Post 2"
    post.save
    posts = Post.all
    posts.size.should eq 2
  end

  it "should find the post by id" do
    post = Post.new
    post.name = "Test Post"
    post.save
    id = post.id
    post = Post.find id
    post.should_not be_nil 
  end

  it "should create a new post" do
    post = Post.new
    post.name = "Test Post"
    post.body = "Test Post"
    post.save
    post.id.should eq 1
  end

  it "should update an existing post" do
    post = Post.new
    post.name = "Test Post"
    post.save
    post.name = "Test Post 2"
    post.save
    post = Post.find 1
    if post
      post.name.should eq "Test Post 2"
    end
  end

  it "should destroy a post" do
    post = Post.new
    post.name = "Test Post"
    post.save
    id = post.id
    post.destroy
    post = Post.find id
    post.should be_nil
  end
end
