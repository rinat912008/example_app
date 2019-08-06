class PostDecorator < ApplicationDecorator
  delegate_all

  def published_at
    object.created_at.strftime('%A, %B %e')
  end
end
