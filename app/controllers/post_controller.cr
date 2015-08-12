require "../models/*"

class PostController < Base::Controller
  property :posts, :post

  actions :index, :new, :create, :read, :edit, :update, :delete

  layout "default", "#{__DIR__}/../views/layouts"
  
  view "index", "#{__DIR__}/../views/post"
  view "read", "#{__DIR__}/../views/post"
  view "new", "#{__DIR__}/../views/post"
  view "edit", "#{__DIR__}/../views/post"

  def initialize
    @posts = [] of Post
    @post = Post.new
    super
  end
  
  def index
    @posts = Post.all

    respond_to do |format|
      format.html { render_with_layout "index", "default" }
    end
  end

  def new
    respond_to do |format|
      format.html { render_with_layout "new", "default" }
    end
  end

  def create
    post = Post.new
    if post
      post.name = request.parameters["name"]
      post.body = request.parameters["body"]
      post.save
    end
   
    respond_to do |format|
      format.html { redirect_to "/posts" }
    end
  end

  def read
    id = request.parameters["id"]
   
    @post = Post.find(id) 
    respond_to do |format|
      format.html { render_with_layout "read", "default" }
    end
  end

  def edit
    id = request.parameters["id"]
    
    @post = Post.find(id) 
    respond_to do |format|
      format.html { render_with_layout "edit", "default" }
    end
  end

  def update
    id = request.parameters["id"]
    post = Post.find(id) 
    if post
      post.name = request.parameters["name"]
      post.body = request.parameters["body"]
      post.save
    end
    
    respond_to do |format|
      format.html { redirect_to "/posts/#{id}" }
    end
  end

  def delete
    id = request.parameters["id"]
    post = Post.find(id) 
    if post
      post.destroy
    end

    respond_to do |format|
      format.html { redirect_to "/posts" }
    end
  end
end
