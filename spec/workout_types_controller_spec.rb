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

end