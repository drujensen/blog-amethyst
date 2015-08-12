require "../../amethyst/src/amethyst"
#require "amethyst/all"
require "../app/controllers/*"

module Blog
  class Application < Base::App

    settings.configure do |conf|
      conf.environment = "development"
      conf.static_dirs = ["/public"]
    end

    routes.draw do
      all  "/", "post#index"
      
      get  "/posts", "post#index"
      get  "/posts/new", "post#new"
      post  "/posts/create", "post#create"
      get  "/posts/:id", "post#read"
      get  "/posts/:id/edit", "post#edit"
      post "/posts/:id/update", "post#update"
      get  "/posts/:id/delete", "post#delete"

      get  "/login", "login#new"
      post  "/session/create", "login#create"
      get  "/logout", "login#delete"

      register PostController
      register LoginController

    end

  end
end
