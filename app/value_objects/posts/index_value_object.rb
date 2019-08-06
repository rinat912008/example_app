module Posts
  class IndexValueObject < BaseValueObject
    param :user
    option :page
    option :per_page, default: -> { Rails.configuration.application.dig('pagination', 'page_size') }

    def user_posts
      @user_posts ||= user.posts.decorate
    end

    def latest_posts
      @latest_posts ||= PostsRepository.new.latest_posts.page(page).per(per_page).decorate
    end
  end
end
