require 'rails_helper'
require 'spec_helper'

describe "the signup process", :type => :feature do

  it "signs up new user" do
    visit 'users/sign_up'
    within("#new_user") do
      fill_in 'Username', with: 'george'
      fill_in 'Email', with: 'user@gmail.com'
      fill_in 'Password', with: '123456789'
      fill_in 'Password confirmation', with: '123456789'
    end
    click_button 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
    click_link('Sign out')
    expect(page).to have_content 'Signed out successfully.'
  end
  
end
