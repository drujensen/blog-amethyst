class Post < Base::Model
  property :id, :name, :body, :created_at, :updated_at

  def self.make(result)
    post = Post.new
    post.id = result[0] 
    post.name = result[1]
    post.body = result[2]
    post.created_at = result[3]
    post.updated_at = result[4]
    return post
  end

  def self.all
    return self.select(%{SELECT id, name, body, created_at, updated_at FROM
                       posts ORDER BY updated_at desc})
  end

  def self.find(id)
    return self.select_one(%{SELECT id, name, body, created_at, updated_at FROM posts where id = #{id}})
  end
  
  def save
    if id
      updated_at = Time.now
      update(%{UPDATE posts set name="#{name}", body="#{body}",
             updated_at="#{updated_at}" where id=#{id} })
    else
      created_at = Time.now
      updated_at = Time.now
      insert(%{INSERT into posts(name, body, created_at, updated_at)
             values("#{name}","#{body}", "#{created_at}", "#{updated_at}") })
    end
    return true
  end

  def destroy
    return delete(%{DELETE from posts where id=#{id} })
  end

  def last_updated
    last_updated = updated_at
    if last_updated.is_a?(Time)
      formatter = TimeFormat.new("%B %d, %Y")
      last_updated = formatter.format(last_updated)
    end
    return last_updated
  end
end
