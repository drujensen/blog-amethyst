require "crypto/md5"
require "../models/*"

class LoginController < Base::Controller

  actions :new, :create, :delete

  layout "default", "#{__DIR__}/../views/layouts"
  
  view "new", "#{__DIR__}/../views/session"

  def new
    respond_to do |format|
      format.html { render_with_layout "new", "default" }
    end
  end

  def create
    username = request.parameters["username"]
    password = request.parameters["password"]
    respond_to do |format|
      if username == "admin" && Crypto::MD5.hex_digest(password) == "ff2fca5e688561ed5237c9a9445c427a"
        format.html { redirect_to "/" }
      else
        format.html { render_with_layout "new", "default" }
      end
    end
  end

  def delete
    respond_to do |format|
      format.html { redirect_to "/" }
    end
  end

end
