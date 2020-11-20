class StaticPagesController < ApplicationController
  def search
    # fail
    if params[:user_id]
      begin
        @params = {user_id: params[:user_id], page: params[:page]}
        @photos = Flickr.new.photos.search(@params)
        flash.now[:notice] = 'No photos found with the given user id.' unless @photos.any?
      rescue Flickr::FailedResponse => e
        flash.now[:notice] = "No user found with ID# #{params[:user_id]}."
      end
    elsif params[:tags]
      @params = {tags: params[:tags], tag_mode: 'all', page: params[:page]}
      @photos = Flickr.new.photos.search(@params)
      flash.now[:notice] = 'No photos found with the given tags.' unless @photos.any?
    end
  end

  def about
    
  end
end

# id 44 = no photos
# id 1014 = no user