require 'spec_helper'

describe OmniAuth::Strategies::ExactOnlineUS do
  subject { OmniAuth::Strategies::ExactOnlineUS.new({})  }

  describe 'client options' do
    it 'should have correct api url' do
      expect(subject.options.client_options.site).to eq("https://start.exactonline.com")
    end

    it 'should set the right paths' do
      expect(subject.options.client_options.authorize_url).to eq('/api/oauth2/auth')
      expect(subject.options.client_options.token_url).to eq('/api/oauth2/token')
    end
  end
end
