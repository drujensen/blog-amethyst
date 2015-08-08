class Post
  property :id
  property :name
  property :body

  def self.all
    posts = [] of Post
    posts << Post.find(1)
    return posts
  end

  def self.find(id)
    post = Post.new(id)
    post.name = "My First Post"
    return post
  end

  def initialize(id = 0)
    @id = id
  end

end
