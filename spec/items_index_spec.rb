require 'rails_helper'

RSpec.describe 'Items Index', type: :feature do

  it 'has the page title "List of Equipment"' do
    visit items_path
    expect(page).to have_css(".jumbotron-heading", text: "List of Equipment")
  end

  it 'adds a user' do
    visit new_user_registration_path
    fill_in('Email', with: 'Test@test.com')
    fill_in('Password', with: 'password')
    fill_in('Password confirmation', with: 'password')
    click_button('Sign up')
    expect(page).to have_css("h1", text: "Thanks for logging in, test@test.com")
  end

  it 'adds an item for a user' do
    visit new_user_registration_path
    fill_in('Email', with: 'Test2@test.com')
    fill_in('Password', with: 'password')
    fill_in('Password confirmation', with: 'password')
    click_button('Sign up')
    click_on('Add a new item')
    fill_in('Manufacturer *', with: 'Test Company')
    fill_in('Model', with: 'Test model')
    fill_in('Price', with: '77')
    fill_in('Weight', with: '7')
    fill_in('Description', with: 'test description')
    fill_in('Serial number', with: 'test serial_number')
    fill_in('Color', with: 'Test color')
    page.attach_file('Image', Rails.root + 'spec/fixtures/files/Maeby.jpg')
    click_button('Create Item')
    expect(page).to have_css("div", text: "You added a Test model for: test2@test.com")
  end

end
