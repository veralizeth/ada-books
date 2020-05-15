require "test_helper"

describe UsersController do
  it "must get login_form" do
    get login_path
    must_respond_with :success
  end

  describe "must get login" do
    it "can login new user" do
      # scope = Uses in all the it.
      user = nil
      expect {
        user = login()
      }.must_differ "User.count", 1

      must_respond_with :redirect

      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
      expect(user.username).must_equal "Grace Hopper"
    end

    it "can login an existing user" do
      user = User.create(username: "Ed Sheeran")

      expect {
        login(user.username)
      }.wont_change "User.count"
    end
  end

  describe "logout" do
    it "can logout  a logged in user" do
      # Arrange

      login()
      expect(session[:user_id]).wont_be_nil

      # Act

      post logout_path

      expect(session[:user_id]).must_be_nil
    end
  end

  describe "current user" do
    it "can return the page if the user is logged in " do
      #Arrage
      login()
      #Act
      get current_user_path

      #Assert
      must_respond_with :success
    end

    it "redirects us back if the user is not logged in" do
      #Act
      get current_user_path

      #Assert
      must_respond_with :redirect

      expect(flash[:error].must_equal "You must be logged in to view this page")
    end
  end
end
