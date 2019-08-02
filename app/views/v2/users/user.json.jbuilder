json.user do
  json.call(
    @user,
    :id,
    :email,
    :username,
    :first_name,
    :last_name,
    :access_level,
    :collection
  )
  json.token token
end
