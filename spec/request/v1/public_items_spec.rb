require "rails_helper"

RSpec.describe 'Public items request spec', type: :request do
  let(:user) { create :user }

  before do
    3.times { create :item, user: user }
  end

  describe '#GET api/items' do
    let(:items_response) { JSON.parse(response.body)['data'] }

    subject { get '/api/items' }

    it 'renders a list of items' do
      subject
      expect(response.response_code).to eq(200)
      expect(items_response.length).to eq(3)
    end

    it 'renders the correct attributes for an item' do
      subject
      expect(items_response.first['manufacturer']).to be_a String
      expect(items_response.first['model']).to be_a String
      expect(items_response.first['price']).to be_a Numeric
    end
  end
end
