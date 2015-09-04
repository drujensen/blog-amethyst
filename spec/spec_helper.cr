require "spec"
require "../config/application"

Base::App.settings.environment = "test"

Post.drop
Post.create

