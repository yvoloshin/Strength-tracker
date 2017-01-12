require 'rails_helper'
require 'spec_helper'

describe "the signup process" do

  it "signs up new users, creates and edits workout" do
    visit  new_user_registration_path
    within("#new_user") do
      fill_in 'Username', with: 'user1'
      fill_in 'Email', with: 'user1@gmail.com'
      fill_in 'Password', with: '123456789'
      fill_in 'Password confirmation', with: '123456789'
    end
    click_button('Sign up')
    expect(page).to have_content 'Welcome! You have signed up successfully.'
    click_link('Sign out')
    expect(page).to have_content 'Signed out successfully.'
    visit new_user_registration_path
    within("#new_user") do
      fill_in 'Username', with: 'user2'
      fill_in 'Email', with: 'user2@gmail.com'
      fill_in 'Password', with: '123456789'
      fill_in 'Password confirmation', with: '123456789'
    end
    click_button('Sign up')
    expect(page).to have_content 'Welcome! You have signed up successfully.'
    click_link('Sign out')
    expect(page).to have_content 'Signed out successfully.'
  
    visit new_user_session_path
    fill_in 'Log in with your user name or email', with: 'user1'
    fill_in 'Password', with: '123456789'
    click_button "Log in"
 
    expect(page).to have_content 'Signed in successfully.'
    click_link 'New Workout Routine'
    within "#new_workout_type" do
      fill_in 'What will you call this workout?', with: "User1's Test Workout"
      fill_in 'Add a brief description of this workout.', with: "User1's Test Workout"
      fill_in id: 'workout_type_exercise_types_attributes_0_name', with: 'Exercise 1'
      fill_in id: 'workout_type_exercise_types_attributes_0_sets', with: '3'
      fill_in id: 'workout_type_exercise_types_attributes_0_reps', with: '10'
      fill_in id: 'workout_type_exercise_types_attributes_0_load', with: '50'
      fill_in id: 'workout_type_exercise_types_attributes_1_name', with: 'Exercise 2'
      fill_in id: 'workout_type_exercise_types_attributes_1_sets', with: '3'
      fill_in id: 'workout_type_exercise_types_attributes_1_reps', with: '10'
      fill_in id: 'workout_type_exercise_types_attributes_1_load', with: '50'
    end
    click_button 'Create Workout'
    expect(page).to have_current_path(root_path)
    expect(page).to have_content "User1's Test Workout"

    click_link('Sign out')
    expect(page).to have_content 'Signed out successfully.'

    visit new_user_session_path
    fill_in 'Log in with your user name or email', with: 'user2'
    fill_in 'Password', with: '123456789'
    click_button "Log in"

    # try to edit another user's routine


  end
  

end