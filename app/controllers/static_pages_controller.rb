class StaticPagesController < ApplicationController
  def search
    if params[:user_id]
      begin
        @photos = Flickr.new.photos.search(user_id: params[:user_id])
        flash.now[:notice] = 'No photos found with the given user id.' unless @photos.any?
      rescue Flickr::FailedResponse => e
        flash.now[:notice] = "No user found with ID# #{params[:user_id]}."
      end
    end
  end
end

# id 44 = no photos
# id 1014 = no user