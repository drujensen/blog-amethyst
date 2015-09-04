#require "../../amethyst-model/src/amethyst-model"
require "active_record"
require "mysql_adapter"
require "markdown/markdown"

class Post < ActiveRecord::Model
  name Post
  adapter mysql

  primary id :: Int  
  field name :: String
  field body :: String
  field created_at :: Time
  field updated_at :: Time


  def self.all criteria
    Post.index
  end

  def self.clear
    Post.index.each do |post|
      post.delete
    end
  end

  def self.find id
    Post.read id
  end

  def save
    if id
      created_at = Time.now
      updated_at = Time.now
      create
    else
      updated_at = Time.now
      update
    end
  end

  def destroy
    delete
  end

  def last_updated
    last_updated = updated_at
    if last_updated.is_a?(Time)
      formatter = TimeFormat.new("%B %d, %Y")
      last_updated = formatter.format(last_updated)
    end
    return last_updated
  end

  def markdown_body
    markdown_body = body
    if markdown_body.is_a?(String)
      markdown_body = Markdown.to_html(markdown_body)
    end
    return markdown_body
  end
end
