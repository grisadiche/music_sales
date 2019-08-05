require "rails_helper"

RSpec.describe 'User items API request spec', type: :request do
  let!(:user) { create :user }
  let(:headers) do
    { 'Authorization' => "Basic dGVzdF91c2VyQHRlc3QuY29tOjEyMzQ1Njc4OTAxMjM0NTY3ODkw" }
  end

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
      get '/api/user_items', params: {}, headers: headers
      expect(response.response_code).to eq(200)
    end
  end

  describe '#POST api/user_items' do
    let(:params) do
      { user_item: attributes_for(:item).merge(image: image_encoded) }.as_json
    end

    let(:image_encoded) do
      File.read(File.join(Rails.root, 'spec', 'request', 'fixtures', 'base_64_image_example.txt'))
    end

    it 'saves an item for a user via the api' do
      post '/api/user_items', params: params, headers: headers
      expect(response.status).to eq(201)
    end
  end

  describe '#PUT api/user_items' do
    let!(:params) do
      { user_item: attributes_for(:item).merge(image: image_encoded) }.as_json
    end

    let!(:image_encoded) do
      File.read(File.join(Rails.root, 'spec', 'request', 'fixtures', 'base_64_image_example.txt'))
    end

    it 'updates an item for a user via the api' do
      # put '/api/user_items/update_path(item)', params: params, headers: headers
      put '/api/user_items/18', params: params, headers: headers
      expect(response.status).to eq(200)
    end
  end
end
