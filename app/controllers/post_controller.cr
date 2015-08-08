require "../models/*"

class PostController < Base::Controller
  property :posts, :post

  actions :index, :new, :create, :read, :edit, :update, :delete

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
      format.html { render "index" }
    end
  end

  def new
    @post = Post.new
    
    respond_to do |format|
      format.html { render "new" }
    end
  end

  def create
    @post = Post.new

    respond_to do |format|
      format.html { redirect_to "/post/1" }
    end
  end

  def read
    id = request.path_parameters["id"]
    @post = Post.find(id) 

    respond_to do |format|
      format.html { render "read" }
    end
  end

  def edit
    id = request.path_parameters["id"]
    @post = Post.find(id) 

    respond_to do |format|
      format.html { render "edit" }
    end
  end

  def update
    id = request.path_parameters["id"]
    @post = Post.find(id) 

    respond_to do |format|
      format.html { redirect_to "/posts/#{id}" }
    end
  end

  def delete
    id = request.path_parameters["id"]
    @post = Post.find(id) 


    respond_to do |format|
      format.html { redirect_to "/posts" }
    end
  end
end
