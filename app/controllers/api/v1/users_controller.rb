module Api
  module V1
    class UsersController < ApplicationController
      def index
        if filter
          find_user(filter_user)
        else
          @users = User.all
        end

        render json: @users, status: :ok
      end

      def create
        @user = User.new(user_params)

        if @user.save
          render json: @user, status: :ok
        else
          render status: :bad_request
        end
      end

      private

      def filter_user
        @filter_user ||= params[:filter][:user] || nil
      end

      def filter
        @filter ||= params[:filter] || nil
      end

      def find_user(search_term)
        @users = User.where('username ILIKE ?', "%#{search_term}%")
      end

      def user_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:username])
      end
    end
  end
end
