json.user do
  json.call(
    @user,
    :id,
    :email,
    :first_name,
    :last_name
  )
  json.token token
end
