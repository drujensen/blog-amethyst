require "crypto/md5"
require "../models/*"

class LoginController < Base::Controller
  property :authorized
  
  actions :new, :create, :delete
  before_action :authorize, only: [:new, :create, :delete]

  layout "default", "#{__DIR__}/../views/layouts"
  
  view "new", "#{__DIR__}/../views/session"

  def initialize
    @authorized = false
    super
  end
  
  def new
    @authorized = session.has_key? :authorized 
    respond_to do |format|
      format.html { render_with_layout "new", "default" }
    end
  end

  def create
    @authorized = session.has_key? :authorized 
    username = request.parameters["username"]
    password = request.parameters["password"]
    if username == "admin" && Crypto::MD5.hex_digest(password) == "ff2fca5e688561ed5237c9a9445c427a"
      session[:authorized] = "true"
    end
    respond_to do |format|
      format.html { redirect_to "/" }
    end
  end

  def delete
    @authorized = session.has_key? :authorized 
    destroy_session
    respond_to do |format|
      format.html { redirect_to "/" }
    end
  end

  def authorize
    @authorized = session.has_key? :authorized
    return true
  end
 

end
