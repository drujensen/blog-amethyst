require "amethyst-model"
#require "../../amethyst-model/src/amethyst-model"
require "markdown/markdown"
require "json"

include Amethyst::Model

class Post < Model
  fields({ name: "VARCHAR(255)", body: "TEXT" })

  json_mapping({
    id: Int32,
    name: String,
    body: String,
    created_at: Time,
    updated_at: Time,
  })
  
  def initialize
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
