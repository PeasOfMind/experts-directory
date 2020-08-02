class MembersController < ApplicationController
  include MembersHelper

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
    @friends = [];
    @member.friends.each do |friend|
      friend = { 
        name: friend.name,
        link: URI.join(request.base_url, member_path(friend.id))
      }
      @friends.push(friend)
    end
  end

  def create
    @member = Member.create(create_params)
  end
  
  def update
    # define a friendship
    member = Member.find(params[:id])
    member.friendships.create(friend_id: update_param)
    head(:no_content)
  end

  def search
    member = Member.find(params[:member_id])
    @search_path = search_connections(member, params[:keywords])
  end

  def update_param
    params.require(:friend_id)
  end

  def create_params
    params.permit(:name, :website)
  end

end
