module Api
  module V1
    class MessagesController < ApplicationController
      def index
        if filter
          if filter_by_user
            @messages = find_user_messages(filter_by_user)
          elsif filter_by_channel
            @messages = find_channel_messages(filter_by_channel)
          end

        else
          @messages = Message.all
        end

        render json: @messages, status: :ok
      end

      def create
        @message = Message.new(message_params)

        channel_id = @message.channel_id
        user = User.find(@message.user_id)

        if user.channels.where(id: channel_id).length > 0
          if @message.save
            render json: @message, status: :created
          else
            render status: :bad_request
          end
        else
          render status: :forbidden
        end

      end

      private

      def filter_by_user
        @filter_user ||= params[:filter][:user] || nil
      end

      def filter_by_channel
        @filter_channel ||= params[:filter][:channel] || nil
      end

      def filter
        @filter ||= params[:filter] || nil
      end

      def find_user_messages(user)
        user = User.where(username: user).first
        @messages = Message.where(user_id: user.id)
      end

      def find_channel_messages(channel)
        channel = Channel.where(name: channel).first
        @messages = Message.where(channel_id: channel.id)
      end

      def message_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:content, :channel, :user])
      end
    end
  end
end
