# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
test_user = User.find_or_create_by!(email: 'user@test.com') do |user|
  user.password = 'Testing123'
end

item = test_user.items.find_or_create_by!(manufacturer: 'Test Company', model: 'Test Model', price: 777, color: 'test color', weight: 7, description: 'some random description', serial_number: '1234567') do |item|
  item.image.attach(io: File.open(Rails.root.join("spec/fixtures/files/Maeby.jpg")), filename: 'Maeby.jpg')
end
# test_item1 = Item.create( manufacturer: 'Test Company', model: 'Test Model', price: 777, image: Rails.root.join'spec/fixtures/files/Maeby.jpg', user: test_user })

