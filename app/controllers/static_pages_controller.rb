class StaticPagesController < ApplicationController
  def search
    if params[:user_id]
      begin
        @flickr = Flickr.new
        @params = {user_id: params[:user_id], page: params[:page]}
        @photos = @flickr.photos.search(@params)
        if @photos.none?
          flash.now[:notice] = "No photos found for User ID #{params[:user_id]}."
          flash.now[:suggestion] = "Why not try #{random_user}?"
        end
      rescue Flickr::FailedResponse => e
        flash.now[:notice] = "No user found with ID #{params[:user_id]}."
        flash.now[:suggestion] = "Why not try #{random_user}?"
      end
    elsif params[:tags]
      @flickr = Flickr.new
      @params = {tags: params[:tags], tag_mode: 'all', page: params[:page], sort: 'relevance'}
      @photos = @flickr.photos.search(@params)
      if @photos.none?
        flash.now[:notice] = "No photos found with the given tags. (Separate tags with commas.)"
        flash.now[:suggestion] = "Why not try #{random_tag}?"
      end
    end
  end

  def about
    render :about
  end

  private

  def random_user
    suggestion = @flickr.interestingness.getList(per_page: 1, page: (rand(100) + 1)).first.owner
    view_context.link_to suggestion, search_path(params: { user_id: suggestion })
  end

  def random_tag
    loop do
      suggestion = @flickr.interestingness.getList(per_page: 1, page: (rand(300) + 1), extras: 'tags').first['tags'].split.first(3).join(', ')
      return view_context.link_to suggestion, search_path(params: { tags: suggestion }) unless suggestion.blank?
    end
  end
end
