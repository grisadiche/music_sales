FactoryBot.define do
  factory :item do
    manufacturer  { "Test Manufacturer" }
    model  { "Test Model" }
    weight { 9 }
    price { 1111 }
    description { "some test description"}
    serial_number { "some serial number"}
    color { "red" }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/Maeby.jpg'), 'image/jpeg') }
    user
  end
end
