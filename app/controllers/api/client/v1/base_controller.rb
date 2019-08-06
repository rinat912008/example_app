module Api
  module Client
    module V1
      class BaseController < ApiController
        before_action :authenticate_user!
      end
    end
  end
end
