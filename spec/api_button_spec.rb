require 'rails_helper'

RSpec.describe 'API Button', type: :feature do
  it 'has an API key button' do
    visit new_user_registration_path
    fill_in('Email', with: 'Test@test.com')
    fill_in('Password', with: 'password')
    fill_in('Password confirmation', with: 'password')
    click_button('Sign up')
    click_link 'Profile Page'
    expect(page).to have_link('Create API Key')
  end

  it 'creates an API key' do
    visit user_session_path
    fill_in('Email', with: 'Test@test.com')
    fill_in('Password', with: 'password')
    click_button('Log In')
    click_link 'Profile Page'
    click_link 'Create API Key'
    expect(current_path).to eq(api_button_path)
  end

  it 'displays an API key when existing' do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    visit profile_users_path
    expect(page).to have_text("API Key: 12345678901234567890")
  end
end
