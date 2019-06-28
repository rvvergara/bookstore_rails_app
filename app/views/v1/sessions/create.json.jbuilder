json.user do
  json.call(
    @user,
    :id,
    :email,
    :username,
    :first_name,
    :last_name
  )
  json.token token
end