class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts_vo = Posts::IndexValueObject.new(current_user, page: params[:page])
  end
end
