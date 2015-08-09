class Post < Base::Model
  property :id
  property :name
  property :body

  def self.make(result)
    post = Post.new
    post.id = result[0] 
    post.name = result[1]
    post.body = result[2]
    return post
  end

  def self.all
    return self.select(%{SELECT id, name, body FROM posts})
  end

  def self.find(id)
    return self.select_one(%{SELECT id, name, body FROM posts where id = #{id}})
  end
  
  def save
    if id
      update(%{UPDATE posts set name="#{name}", body="#{body}" where id=#{id} })
    else
      insert(%{INSERT into posts(name, body)  values("#{name}","#{body}") })
    end
    return true
  end

  def destroy
    return delete(%{DELETE from posts where id=#{id} })
  end
end
