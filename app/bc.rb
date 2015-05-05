require 'dotenv'
require 'http'

Dotenv.load if ENV['APP_ENV'] == 'development'

class BC
  attr_reader :user, :password, :app, :account_id

  def initialize
    @user = ENV['BC_USER']
    @password = ENV['BC_PASSWORD']
    @app = ENV['BC_APP']
    @account_id = ENV['BC_ACCOUNT_ID']
  end

  def client_emails
    [].tap do |emails|
      active_projects_ids.each do |project_id|
        response = HTTP
          .basic_auth(user: user, pass: password)
          .headers(accept: 'application/json')
          .headers('User-Agent' => app)
          .get("https://basecamp.com/#{account_id}/api/v1/projects/#{project_id}/accesses")

        emails << JSON.parse(response).map { |elem| elem['email_address'] if elem['is_client'] == true }
      end
    end.flatten.compact.uniq
  end

  private

  def active_projects_ids
    response = HTTP
      .basic_auth(user: user, pass: password)
      .headers(accept: 'application/json')
      .headers('User-Agent' => app)
      .get("https://basecamp.com/#{account_id}/api/v1/projects")

    JSON.parse(response).map { |elem| elem['id'] }
  end
end
