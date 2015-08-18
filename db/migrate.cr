require "../config/application"

Base::App.settings.environment = "development"

puts "Dropping Development Post DB"
Post.drop

puts "Creating Development Post DB"
Post.create

Base::App.settings.environment = "test"

puts "Dropping Test Post DB"
Post.drop

puts "Creating Test Post DB"
Post.create

