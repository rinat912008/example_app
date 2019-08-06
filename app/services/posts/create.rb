module Posts
  class Create < BaseServiceObject
    param :user

    option :message
    option :published, default: -> { true }

    def call
      validate
      return self unless valid?

      post.save!
      # some logic after saving Post
      self.result = post
      self
    end

    private

    def validate
      errors.add(:base, 'please specify user') unless user
      errors.merge_with_models(post) unless post.valid?
    end

    def post
      @post ||= Post.new(user: user, message: message, published: published)
    end
  end
end
