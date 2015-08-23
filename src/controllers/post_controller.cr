require "../models/*"

class PostController < Base::Controller
  property :posts, :post, :authorized

  actions :index, :new, :create, :read, :edit, :update, :delete
  before_action :authorize, only: [:index, :new, :create, :read, :edit,
                                   :update, :delete]

  layout "default", "#{__DIR__}/../views/layouts"
  
  view "index", "#{__DIR__}/../views/post"
  view "read", "#{__DIR__}/../views/post"
  view "new", "#{__DIR__}/../views/post"
  view "edit", "#{__DIR__}/../views/post"

  def initialize
    @authorized = false
    @posts = [] of Post
    @post = Post.new
    super
  end
 
  def index
    @posts = Post.all("ORDER BY created_at DESC")
    respond_to do |format|
      format.html { render_with_layout "index", "default" }
    end
  end

  def new
    respond_to do |format|
      if @authorized
        format.html { render_with_layout "new", "default" }
      else
        format.html { redirect_to "/posts" }
      end
    end
  end

  def create
    if @authorized
      post = Post.new
      if post
        post.name = request.parameters["name"]
        post.body = request.parameters["body"]
        post.save
      end
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
      if @authorized
        format.html { render_with_layout "edit", "default" }
      else
        format.html { redirect_to "/posts" }
      end
    end
  end

  def update
    id = request.parameters["id"]
    if @authorized
      post = Post.find(id) 
      if post
        post.name = request.parameters["name"]
        post.body = request.parameters["body"]
        post.save
      end
    end
    
    respond_to do |format|
      format.html { redirect_to "/posts/#{id}" }
    end
  end

  def delete
    id = request.parameters["id"]
    if @authorized
      post = Post.find(id) 
      if post
        post.destroy
      end
    end

    respond_to do |format|
      format.html { redirect_to "/posts" }
    end
  end

  def authorize
    @authorized = session.has_key? :authorized
    return true
  end

end
