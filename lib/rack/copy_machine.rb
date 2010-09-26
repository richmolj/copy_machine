class Rack::CopyMachine
  autoload :AssetServer, 'rack/copy_machine/asset_server'

  def initialize(app, options = {})
    @app = asset_server(app)
  end

  def call(env); dup._call(env); end

  def _call(env)
    @request = Rack::Request.new(env)

    status, headers, body = @app.call(env)
    @response = Rack::Response.new(body, status, headers)
    inject_copy_notification

    @response.finish
  end

  def inject_copy_notification
    modify_body do
      ::ERB.new(::File.read(::File.dirname(__FILE__) + "/views/notifications.html.erb")).result
    end
  end

  def modify_body
    full_body = @response.body.join
    full_body.sub! /<\/head>/, "</head>\n" + yield

    @response["Content-Length"] = full_body.size.to_s
    @response.body = [full_body]
  end

  private

  def asset_server(app)
    AssetServer.new(app, Rack::Static.new(app, :urls => ["/__rack_copy_machine__"], :root => public_path))
  end

  def public_path
    ::File.expand_path(::File.dirname(__FILE__) + "/copy_machine/public")
  end

end
