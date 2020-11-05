module Api
  module V1
    class UserChannelsController < ApplicationController
      def create
        @user_channel = UserChannel.new(user_channel_params)
        
        if UserChannel.where(user_id: @user_channel.user_id, channel_id: @user_channel.channel_id).length > 0
          render status: :conflict
        else
          if @user_channel.save
            render json: @user_channel, status: :created
          else
            render status: :bad_request
          end
        end

      end

      private

      def user_channel_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: ['user-id', 'channel-id'])
      end

    end
  end
end
