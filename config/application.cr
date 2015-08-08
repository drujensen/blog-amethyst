require "../../amethyst/src/amethyst"
require "../app/controllers/*"

module Blog
  class Application < Base::App

    settings.configure do |conf|
      conf.environment = "development"
      conf.static_dirs = ["/public/images", "/public/css", "/public/js"]
    end

    routes.draw do
      all  "/", "posts#index"

      get  "/posts", "posts#index"
      get  "/posts/new", "posts#new"
      post  "/posts", "posts#create"
      get  "/posts/:id", "posts#read"
      get  "/posts/:id/edit", "posts#edit"
      post  "/posts/:id", "posts#update"
      get  "/posts/:id/delete", "posts#delete"
      register PostController
    end

    use Middleware::TimeLogger
  end
end

app = Blog::Application.new
app.serve
