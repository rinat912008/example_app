class PostsRepository < BaseRepository
  option :relation, default: -> { Post }

  def latest_posts
    relation.published.joins(:user).select('posts.*', 'users.email as user_email').order(created_at: :desc)
  end

  # most liked posts
  def popular_posts; end
end
