#require "../../amethyst-model/src/amethyst-model"
require "amethyst-model"
require "amethyst-model/sqlite_adapter"
require "markdown/markdown"

class Post < Amethyst::Model::Model
  adapter sqlite
  
  sql_mapping({ 
    name: "CHAR(255)", 
    body: "TEXT" 
  })

  def last_updated
    last_updated = updated_at
    if last_updated.is_a?(String)
      last_updated = TimeFormat.new("%F %X").parse(last_updated)
    end
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
