json.user do
  json.call(
    @user,
    :id,
    :email,
    :username,
    :first_name,
    :last_name,
    :access_level
  )
  json.token token
end