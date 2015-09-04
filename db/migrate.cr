require "../config/application"

Base::App.settings.environment = "development"

Post.drop
Post.create


