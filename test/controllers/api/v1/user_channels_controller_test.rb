require 'test_helper'

module Api
  module V1
    class UserChannelsControllerTest < ActionDispatch::IntegrationTest

      def setup
        @user_1 = create(:user, id: 1, username: 'Peter Parker')
        @channel_one = create(:channel, id: 1, name: 'Justice League')
        @params = {
                      "data": {
                          "type": "user-channels",
                          "attributes": {
                              "user-id": 1,
                              "channel-id": 1
                          }
                      }
                  }
      end

      test "user should be able to join channel if they haven't already" do
        post api_v1_user_channels_url, params: @params
        body = JSON.parse(response.body)
        user_channel = UserChannel.last

        assert_equal(1, user_channel.user_id)
        assert_equal(1, user_channel.channel_id)
        assert_response(:created)
      end

      test "user should not be able to join the channel if they have already" do
        @user_channel = create(:user_channel)
        post api_v1_user_channels_url, params: @params

        assert_response(:conflict)
      end

    end
  end
end
