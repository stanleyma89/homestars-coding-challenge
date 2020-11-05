module Api
  module V1
    class ChannelsController < ApplicationController
      def index
        if filter
          find_channel(filter_channel)
        else
          @channels = Channel.all
        end

        render json: @channels, status: :ok
      end

      def create
        @channel = Channel.new(channel_params)

        if @channel.save
          render json: @channel, status: :ok
        else
          render status: :bad_request
        end
      end

      private

      def filter_channel
        @filter_channel ||= params[:filter][:channel] || nil
      end

      def filter
        @filter ||= params[:filter] || nil
      end

      def find_channel(search_term)
        @channels = Channel.where('name ILIKE ?', "%#{search_term}%")
      end

      def channel_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:name])
      end
    end
  end
end
