module Api
  module Client
    module V1
      module Posts
        class IndexPage < Api::BasePage
          param :user

          section :data

          def data
            {
              user_posts: user.posts.published.map { |post| Api::Client::V1::Posts::ShowPage.new(post).to_h },
              latest_posts: latest_posts.map { |post| Api::Client::V1::Posts::ShowPage.new(post).to_h }
            }
          end

          private

          def latest_posts
            @latest_posts ||= pagination? ? relation.page(page_number).per(page_size) : relation
          end

          def relation
            @relation ||= PostsRepository.new.latest_posts
          end
        end
      end
    end
  end
end
