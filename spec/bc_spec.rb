require 'spec_helper'

describe BC do
  describe '#client_emails' do
    let(:bc_instance) { described_class.new }

    before(:each) do
      allow(bc_instance).to receive(:client_emails_dirty) do
        [
          ['one@number.com', nil, 'two@number.com'],
          [nil, nil],
          'three@number.com',
          nil,
          ['one@number.com', 'two@number.com']
        ]
      end
    end

    it 'returns array' do
      expect(bc_instance.client_emails.class).to eq(Array)
    end

    it 'returns compacted array' do
      expect(bc_instance.client_emails.include?(nil)).to eq(false)
    end

    it 'returns array with uniq elements' do
      expect(bc_instance.client_emails)
        .to eq(['one@number.com', 'two@number.com', 'three@number.com'])
    end

    it 'returns array of emails' do
      EMAIL_REGEX = /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i

      bc_instance.client_emails.each do |elem|
        expect(elem).to match(EMAIL_REGEX)
      end
    end
  end
end
