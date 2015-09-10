require "crypto/md5"

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
    respond_to do |format|
      format.html { render_with_layout "new", "default" }
    end
  end

  def create
    username = request.parameters["username"]
    password = request.parameters["password"]

    # To change the password, uncomment the next line and copy into digest
    # into the check.
    # puts "Encrypted Password: #{Crypto::MD5.hex_digest(password)}"
    
    if username == "admin" && Crypto::MD5.hex_digest(password) == "5f4dcc3b5aa765d61d8327deb882cf99"
      session[:authorized] = "true"
    end
    respond_to do |format|
      format.html { redirect_to "/" }
    end
  end

  def delete
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
