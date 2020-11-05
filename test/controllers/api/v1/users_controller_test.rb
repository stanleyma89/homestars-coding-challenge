require 'test_helper'

module Api
  module V1
    class UsersControllerTest < ActionDispatch::IntegrationTest

      def setup
        @user = create(:user)
        @params = {
                      "data": {
                          "type": "users",
                          "attributes": {
                              "username": "user one"
                          }
                      }
                  }
      end

      test "index method should return status 200 OK" do
        get api_v1_users_url

        assert_response :ok
      end

      test "should return a list of users that matches search term" do
        get api_v1_users_url, params: { filter: { user: 'Starfox'} }
        body = JSON.parse(response.body)

        assert_equal("Starfox", body['data'][0]['attributes']['username'])
      end

      test "should be able to create a user" do
        post api_v1_users_url, params: @params
        user = User.last

        assert_response(:ok)
        assert_equal("user one", user.username)
      end

      test "should not be able to create a user with the same name" do
        @params = {
                      "data": {
                          "type": "users",
                          "attributes": {
                              "username": "Starfox"
                          }
                      }
                  }
        post api_v1_users_url, params: @params

        assert_response(:bad_request)
      end

    end
  end
end
