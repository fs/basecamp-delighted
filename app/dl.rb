require 'delighted'

if ENV['APP_ENV'] == 'development'
  require 'dotenv'
  Dotenv.load
end

Delighted.api_key = ENV['DELIGHTED_API_KEY']

class DL
  attr_reader :delay

  def initialize
    @delay = ENV['DELIGHTED_DELAY']
  end

  def add_peoples(client_emails)
    client_emails.each do |client_email|
      Delighted::Person.create(
        email: client_email,
        delay: delay
      )
    end
  end
end
