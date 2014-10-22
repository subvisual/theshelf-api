class UserToken
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = app.call(_call(env))

    [status, headers, response]
  end

  private
  attr_reader :app

  def _call(env)
    header = parse_authorization_header(env)
    header.present? ? update_env(env, header) : env
  end

  def parse_authorization_header(env)
    env['HTTP_AUTHORIZATION']
  end

  def update_env(env, header)
    env['USER_TOKEN'] = header.split(' ')[1].split('=')[1]
    env
  end
end
