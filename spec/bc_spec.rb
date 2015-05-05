require 'spec_helper'

describe BC do
  describe '#client_emails' do
    let(:bc_instance) { described_class.new }

    it 'returns array' do
      expect(bc_instance.client_emails.class).to eq(Array)
    end

    it 'returns array of emails' do
      EMAIL_REGEX = /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i

      bc_instance.client_emails.each do |elem|
        expect(elem).to match(EMAIL_REGEX)
      end
    end
  end
end
