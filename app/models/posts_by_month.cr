require "amethyst-model/sqlite_adapter"

class PostsByMonth < Amethyst::Model::RoModel
  adapter sqlite
  
  sql_mapping({ 
    month: "strftime('%m', updated_at) as Month",
    year: "strftime('%Y', updated_at) as Year",
    count: "COUNT(*)"
  }, "posts")

  def self.all_by_month
    PostsByMonth.all("GROUP BY Year, Month")
  end
end

