require "./spec_helper"

describe PostController do

  Spec.before_each do
    Post.clear
  end

  describe "#index" do
    
    it "should return a list of posts" do
      post = Post.new
      post.name = "Test Post"
      post.save
      
      controller = create_controller_instance(PostController)
      controller.call_action "index"
      controller.response.body.should contain "Test Post"
    end
  end

  describe "#show" do
    it "should show the details of a post" do
      post = Post.new
      post.name = "Test Post"
      post.save
      
      controller = create_controller_instance(PostController, "GET",
                                              "/posts/#{post.id}")
      controller.call_action "show"
      controller.response.body.should contain "Test Post"
    end
  end

  describe "#new" do
     it "should show the new form" do
      controller = create_controller_instance(PostController)
      controller.session[:authorized] = "true"
      controller.call_action "new"
      controller.response.body.should contain "New Post"
    end
  end

  describe "#create" do
    it "should create a new post" do
      controller = create_controller_instance(PostController, "POST",
                                              "/posts/create?name=Test")
      controller.call_action "create"
      posts = Post.all
      posts.size.should eq 1
    end
  end

  describe "#edit" do
    it "should show the edit form" do
      post = Post.new
      post.name = "Test Post"
      post.save

      controller = create_controller_instance(PostController, "GET",
                                              "/posts/#{post.id}/edit")
      controller.session[:authorized] = "true"
      controller.call_action "edit"
      controller.response.body.should contain "Edit Post"
    end
  end

  describe "#update" do
    it "should update a post" do
      post = Post.new
      post.name = "Test Post"
      post.save

      controller = create_controller_instance(PostController, "POST",
                                              "/posts/#{post.id}/update?name=Test")
      controller.call_action "update"
      post = Post.find post.id
      if post
        post.name.should eq "Test"
      else
        1.should eq 0 #shouldn't get here so fail a test
      end
    end
  end

  describe "#destroy" do
    it "should delete the post" do
      post = Post.new
      post.name = "Test Post"
      post.save

      controller = create_controller_instance(PostController, "GET",
                                              "/posts/#{post.id}/delete")
      controller.session[:authorized] = "true"
      controller.call_action "delete"
      controller.response.body.should contain "OK"
    end
  end

end

