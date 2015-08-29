require "amethyst-model"
#require "../../amethyst-model/src/amethyst-model"
require "markdown/markdown"

include Amethyst::Model

class Post < Model
  fields({ name: "VARCHAR(255)", body: "TEXT" })

  def last_updated
    last_updated = updated_at as Time
    formatter = TimeFormat.new("%B %d, %Y")
    last_updated = formatter.format(last_updated)
  end

  def markdown_body
    markdown_body = body as String
    markdown_body = Markdown.to_html(markdown_body)
  end
end
