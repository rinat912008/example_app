module Api
  module Client
    module V1
      module Posts
        class ShowPage < Tram::Page
          param :post

          section :id, value: -> { post.id }
          section :message, value: -> { post.message }
          section :user

          def user
            {
              user_id: post.user_id,
              user_email: post.try(:user_email)
            }
          end
        end
      end
    end
  end
end
