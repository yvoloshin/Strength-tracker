require 'rails_helper'
require 'spec_helper'

describe "the signup process" do

  it "signs up new users, creates and edits workout" do
    
    #create two users
    visit new_user_registration_path
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
  
    # user1 signs in
    visit new_user_session_path
    fill_in 'Log in with your user name or email', with: 'user1'
    fill_in 'Password', with: '123456789'
    click_button "Log in"
    expect(page).to have_content 'Signed in successfully.'

    #user1 creates public routine
    click_link 'New Workout Routine'
    within "#new_workout_type" do
      fill_in 'What will you call this workout?', with: "User1's Public Workout"
      fill_in 'Add a brief description of this workout.', with: "User1's Public Workout Test"
      fill_in id: 'workout_type_exercise_types_attributes_0_name', with: 'Exercise 1'
      fill_in id: 'workout_type_exercise_types_attributes_0_sets', with: '3'
      fill_in id: 'workout_type_exercise_types_attributes_0_reps', with: '10'
      fill_in id: 'workout_type_exercise_types_attributes_0_load', with: '50'
      fill_in id: 'workout_type_exercise_types_attributes_1_name', with: 'Exercise 2'
      fill_in id: 'workout_type_exercise_types_attributes_1_sets', with: '3'
      fill_in id: 'workout_type_exercise_types_attributes_1_reps', with: '10'
      fill_in id: 'workout_type_exercise_types_attributes_1_load', with: '50'
    end
    click_button 'Create Workout Routine'
    expect(page).to have_current_path(root_path)
    expect(page).to have_content "User1's Public Workout"
    expect(page).to have_css("#public_routines_badge", :text => "1")
    expect(page).to have_css("#my_routines_badge", :text => "1")
    expect(page).to have_selector(:link_or_button, 'Edit')

    #user1 creates private routine
    click_link 'New Workout Routine'
    within "#new_workout_type" do
      fill_in 'What will you call this workout?', with: "User1's Private Workout"
      fill_in 'Add a brief description of this workout.', with: "User1's Private Workout Test"
      choose('workout_type_public_false')
      fill_in id: 'workout_type_exercise_types_attributes_0_name', with: 'Exercise 1'
      fill_in id: 'workout_type_exercise_types_attributes_0_sets', with: '3'
      fill_in id: 'workout_type_exercise_types_attributes_0_reps', with: '10'
      fill_in id: 'workout_type_exercise_types_attributes_0_load', with: '50'
      fill_in id: 'workout_type_exercise_types_attributes_1_name', with: 'Exercise 2'
      fill_in id: 'workout_type_exercise_types_attributes_1_sets', with: '3'
      fill_in id: 'workout_type_exercise_types_attributes_1_reps', with: '10'
      fill_in id: 'workout_type_exercise_types_attributes_1_load', with: '50'
    end
    click_button 'Create Workout Routine'
    expect(page).to have_current_path(root_path)
    expect(page).to have_content "User1's Private Workout"
    expect(page).to have_css("#public_routines_badge", :text => "1")
    expect(page).to have_css("#my_routines_badge", :text => "2")
    expect(page).to have_selector(:link_or_button, 'Edit')

    #user1 edits routine
    page.find(:css, '#home > div:nth-child(2) > div:nth-child(15) > a:nth-child(2)').click #edit button
    fill_in id: 'workout_type_type_name', with: "Edited User1's Test Workout"    
    click_button 'Update'
    expect(page).to have_current_path(root_path)
    expect(page).to have_content "Edited User1's Test Workout"

    click_link('Sign out')
    expect(page).to have_content 'Signed out successfully.'

    # user2 signs in
    visit new_user_session_path
    fill_in 'Log in with your user name or email', with: 'user2'
    fill_in 'Password', with: '123456789'
    click_button "Log in"
    expect(page).to have_content 'Signed in successfully.'

    # don't see button for editing user1's routine
    expect(page).to have_content "User1's Test Workout"
    expect(page).to have_css("#public_routines_badge", :text => "1")
    expect(page).to have_css("#my_routines_badge", :text => "0")
    expect(page).to have_no_selector(:link_or_button, 'Edit')

    # user2 creates workout based on "User1's Test Workout"
    expect(page).to have_current_path(root_path)
    click_link_or_button "Record Results"
    fill_in id: 'workout_exercises_attributes_0_completed_sets_attributes_0_reps', with: '10'
    fill_in id: 'workout_exercises_attributes_0_completed_sets_attributes_0_load', with: '50'
    fill_in id: 'workout_exercises_attributes_0_completed_sets_attributes_1_reps', with: '10'
    fill_in id: 'workout_exercises_attributes_0_completed_sets_attributes_1_load', with: '45'
    fill_in id: 'workout_exercises_attributes_0_completed_sets_attributes_2_reps', with: '10'
    fill_in id: 'workout_exercises_attributes_0_completed_sets_attributes_2_load', with: '45'
    fill_in id: 'workout_exercises_attributes_1_completed_sets_attributes_0_reps', with: '10'
    fill_in id: 'workout_exercises_attributes_1_completed_sets_attributes_0_load', with: '50'
    fill_in id: 'workout_exercises_attributes_1_completed_sets_attributes_1_reps', with: '10'
    fill_in id: 'workout_exercises_attributes_1_completed_sets_attributes_1_load', with: '45'
    fill_in id: 'workout_exercises_attributes_1_completed_sets_attributes_2_reps', with: '10'
    fill_in id: 'workout_exercises_attributes_1_completed_sets_attributes_2_load', with: '45'
    click_button "Save"
    expect(page).to have_content "User1's Test Workout"

    # user1 deletes routine

  end
  

end