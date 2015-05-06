require 'http'

if ENV['APP_ENV'] == 'development'
  require 'dotenv'
  Dotenv.load
end

class BC
  attr_reader :user, :password, :app, :account_id

  def initialize
    @user = ENV['BC_USER']
    @password = ENV['BC_PASSWORD']
    @app = ENV['BC_APP']
    @account_id = ENV['BC_ACCOUNT_ID']
  end

  def client_emails
    client_emails_dirty.flatten.compact.uniq
  end

  private

  def active_projects_ids
    JSON.parse(projects_response).map { |elem| elem['id'] }
  end

  def projects_response
    HTTP
      .basic_auth(user: user, pass: password)
      .headers(accept: 'application/json')
      .headers('User-Agent' => app)
      .get("https://basecamp.com/#{account_id}/api/v1/projects")
  end

  def accesses_response(project_id)
    HTTP
      .basic_auth(user: user, pass: password)
      .headers(accept: 'application/json')
      .headers('User-Agent' => app)
      .get("https://basecamp.com/#{account_id}/api/v1/projects/#{project_id}/accesses")
  end

  def client_emails_dirty
    [].tap do |emails|
      active_projects_ids.each do |project_id|
        emails << JSON.parse(accesses_response(project_id)).map { |elem| elem['email_address'] if elem['is_client'] == true }
      end
    end
  end
end
