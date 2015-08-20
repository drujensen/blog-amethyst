require "../spec_helper"

def create_controller_instance(controller : Base::Controller.class, method =
                               "GET", path = "/")
  request, response = HttpHlp.get_env(method, path)
  controller = controller.new
  controller.set_env(request, response)
  controller
end

class HttpHlp
  property :req
  property :res

  def initialize(method, path)
    @req  = self.class.req(method, path)
    @res = self.class.res(200, "OK")
  end

  def self.get_env(method, path)
    instance = new(method, path)
    return instance.req, instance.res
  end

  def get_env
    return req, res
  end

  def self.req(method, path)
    headers      = HTTP::Headers.new
    base_request = HTTP::Request.new(method, path, headers, "Test")
    request      = Http::Request.new(base_request)
    request
  end

  def self.res(code, body)
    response     = Http::Response.new(code, body)
    response
  end
end
