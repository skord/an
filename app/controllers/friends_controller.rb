class FriendsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_friend, only: [:show]

  # GET /friends
  # GET /friends.json
  def index
    @friends = current_user.friends
  end

  # GET /friends/1
  # GET /friends/1.json
  def show
  end

  # GET /friends/new
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friend_params
      params.fetch(:friend, {})
    end
end
