require "amethyst/all"
#require "../../amethyst/src/amethyst"
require "../app/controllers/*"

module Blog
  class Application < Base::App

    settings.configure do |conf|
      conf.environment = "development"
      conf.static_dirs = ["/public"]
    end

    routes.draw do
      all  "/", "post#index"
      
      register PostController
      get  "/posts", "post#index"
      get  "/posts/new", "post#new"
      post  "/posts/create", "post#create"
      get  "/posts/:id", "post#show"
      get  "/posts/:id/edit", "post#edit"
      post "/posts/:id/update", "post#update"
      get  "/posts/:id/delete", "post#delete"

      register LoginController
      get  "/login", "login#new"
      post  "/session/create", "login#create"
      get  "/logout", "login#delete"
    end

  end
end


