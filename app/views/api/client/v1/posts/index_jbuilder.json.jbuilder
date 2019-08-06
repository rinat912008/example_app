json.data do
  json.user_posts @posts_vo.user_posts do |post|
    json.partial! 'post', post: post
  end

  json.latest_posts @posts_vo.latest_posts do |post|
    json.partial! 'post', post: post
  end
end

# json.data do
#   json.user_posts @posts_vo.user_posts do |post|
#     json.id post.id
#     json.message post.message
#     json.user do
#       json.user_id post.user_id
#       json.user_email post.try(:user_email)
#     end
#   end
#
#   json.latest_posts @posts_vo.latest_posts do |post|
#     json.id post.id
#     json.message post.message
#     json.user do
#       json.user_id post.user_id
#       json.user_email post.try(:user_email)
#     end
#   end
# end
