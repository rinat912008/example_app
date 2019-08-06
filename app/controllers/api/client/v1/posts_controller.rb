module Api
  module Client
    module V1
      class PostsController < Api::Client::V1::BaseController
        def index
          render json: Api::Client::V1::Posts::IndexPage.new(current_user, pagination: pagination_params).to_h
        end

        def create
          outcome = ::Posts::Create.call(current_user, post_params.to_h)

          if outcome.valid?
            render json: Api::Client::V1::Posts::ShowPage.new(outcome.result).to_h
          else
            respond_with_validation_error(outcome, prefix: :post)
          end
        end

        def index_jbuilder
          @posts_vo = ::Posts::IndexValueObject.new(
            current_user,
            page: params[:page][:number],
            per_page: params[:page][:size]
          )
        end

        def index_with_oj
          render json: Oj.dump(
            Api::Client::V1::Posts::IndexPage.new(current_user, pagination: pagination_params).to_h,
            mode: :compat
          )
        end

        def index_with_db
          render json: Post.published.joins(:user).order(created_at: :desc).limit(params[:page][:size])
                           .select(
                             :id,
                             :message,
                             "json_build_object('user_id', posts.user_id, 'user_email', users.email) as user_hash"
                           )
                           .to_json
        end

        private

        def post_params
          params.require(:post).permit(:message, :published)
        end
      end
    end
  end
end
