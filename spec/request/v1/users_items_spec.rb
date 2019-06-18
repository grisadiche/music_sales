require "rails_helper"

RSpec.describe 'User items API request spec', type: :request do
  let!(:user) { create :user }

  before do
    3.times { create :item, user: user  }
  end

  describe '#GET api/user_items' do
    let(:items_response) { JSON.parse(response.body)['data'] }

    it 'returns unauthorized without a valid api key' do
      get '/api/user_items'
      expect(response.response_code).to eq(401)
    end

    it 'returns authorized with a valid api key' do
      get '/api/user_items', params: {}, headers: { 'Authorization' => "Basic dGVzdF91c2VyQHRlc3QuY29tOjEyMzQ1Njc4OTAxMjM0NTY3ODkw" }
      expect(response.response_code).to eq(200)
    end
  end
end

# { 'Authorization' => "dGVzdF91c2VyQHRlc3QuY29tOjEyMzQ1Njc4OTAxMjM0NTY3ODkw" }
