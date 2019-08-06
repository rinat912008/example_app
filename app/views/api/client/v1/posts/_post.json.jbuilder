json.id post.id
json.message post.message
json.user do
  json.user_id post.user_id
  json.user_email post.try(:user_email)
end
