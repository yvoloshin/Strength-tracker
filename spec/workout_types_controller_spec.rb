require "rails_helper"

RSpec.describe WorkoutTypesController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

  end

  describe "GET #new" do
    it "redirect to sign in form" do
      get :new
      expect(response).to redirect_to new_user_session_path
      user = User.create(
        email:                 'fakeuser@gmail.com',
        username:              'fakeusername', 
        password:              'secretPassword',
        password_confirmation: 'secretPassword'
      )
      sign_in user
      get :new
      expect( response ).to render_template( :new )
    end
  end

  describe "workout_types#delete" do
    it "deletes a workout type" do 
      user = User.create(
        email:                 'fakeuser@gmail.com',
        username:              'fakeusername', 
        password:              'secretPassword',
        password_confirmation: 'secretPassword'
      )
      sign_in user
      @type = WorkoutType.create(:type_name => 'test workout type', :user_id => user.id)
      

      # workout_types = WorkoutType.all
      # post :delete, :id => WorkoutType.first.id
      # first_workout_type = WorkoutType.find('50')
      # expect(first_workout_type.id).to eq('50')
      # workout_type = WorkoutType.find_by(type_name: "Bike Muscular Enhancement")
      # expect(workout_type).to eq nil
      # expect(workout_type.id).to eq 50
      # workout_type_id = workout_type.id
      # delete :destroy, :id => @type
      expect{
      delete :destroy, id: @type        
    }.to change(WorkoutType,:count).by(-1)
      expect(WorkoutType,:count).to change
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to root_path

      
      
      # workout_type = WorkoutType.find_by_id(workout_type.id)
      type = WorkoutType.find_by_id(@type.id)
      expect(type).to eq nil
    end
  end



end