require 'test_helper'

module Api
  module V1
    class MessagesControllerTest < ActionDispatch::IntegrationTest

      def setup
        @user_one = create(:user, id: 1, username: 'Bruce Wayne')
        @user_two = create(:user, id: 2, username: 'Peter Parker')
        @channel_one = create(:channel, id: 1, name: 'Justice League')
        @channel_two = create(:channel, id: 2, name: 'The Avengers')
        @message_one = create(:message, content: 'hello', user_id: @user_one.id, channel_id: @channel_one.id)
        @message_two = create(:message, content: 'there', user_id: @user_one.id, channel_id: @channel_one.id)
        @message_three = create(:message, content: 'hi there', user_id: @user_two.id, channel_id: @channel_two.id)
        @params = {
                    "data": {
                        "type": "messsages",
                        "attributes": {
                            "content": "hello this is my first message"
                        },
                        "relationships": {
                            "user": {
                                "data": {
                                    "type": "users",
                                    "id": "1"
                                }
                            },
                            "channel": {
                                "data": {
                                    "type": "channels",
                                    "id": "1"
                                }
                            }
                        }
                    }
                }
      end

      test "index method should return status 200 OK" do
        get api_v1_messages_url

        assert_response(:ok)
      end

      test "should return a list of messages filtered by user" do
        get api_v1_messages_url, params: { filter: { user: 'Bruce Wayne' } }
        body = JSON.parse(response.body)

        assert_equal(2, body['data'].length)
      end

      test "should return a list of messages by channel" do
        get api_v1_messages_url, params: { filter: { channel: 'The Avengers' } }
        body = JSON.parse(response.body)

        assert_equal(1, body['data'].length)
      end

      test "should create a message successfully if user and channel exist" do
        @user_channel = create(:user_channel)

        post api_v1_messages_url, params: @params
        body = JSON.parse(response.body)
        message = Message.last

        assert_equal("hello this is my first message", message.content)
        assert_response(:created)
      end

      test "should not create a message if user has not joined the channel" do
        post api_v1_messages_url, params: @params

        assert_response(:forbidden)
      end

    end
  end
end
