require 'test_helper'

module Api
  module V1
    class ChannelsControllerTest < ActionDispatch::IntegrationTest

      def setup
        @channel = create(:channel)
        @params = {
                      "data": {
                          "type": "channels",
                          "attributes": {
                              "name": "Fantasy Hockey"
                          }
                      }
                  }
      end

      test "index method should return status 200 OK" do
        get api_v1_channels_url

        assert_response(:ok)
      end

      test "should return a list of channels that matches search term" do

        get api_v1_channels_url, params: { filter: { channel: 'fantasy'} }
        body = JSON.parse(response.body)

        assert_equal("Fantasy Football", body['data'][0]['attributes']['name'])
      end

      test "should be able to create a channel" do
        post api_v1_channels_url, params: @params
        channel = Channel.last

        assert_response(:ok)
        assert_equal("Fantasy Hockey", channel.name)
      end

      test "should not be able to create a channel with the same name" do
        @params = {
                      "data": {
                          "type": "channels",
                          "attributes": {
                              "channelname": "Fantasy Hockey"
                          }
                      }
                  }
        post api_v1_channels_url, params: @params

        assert_response(:bad_request)
      end

    end
  end
end
