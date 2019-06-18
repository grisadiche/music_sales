require "rails_helper"

RSpec.describe 'Public items request spec', type: :request do
  let(:user) { create :user }

  before do
    3.times { create :item, user: user }
  end

  describe '#GET api/items' do
    subject { get '/api/items' }

    it 'renders a list of items' do
      subject
      expect(response.code).to eq(200)
      items = JSON.parse(response.body)
      expect(items.first.keys).to eq(%w(foo bar))
    end
  end
end
