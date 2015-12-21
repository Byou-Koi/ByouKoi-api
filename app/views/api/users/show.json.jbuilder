json.user @user
json.lovers @lovers do |lover|
  json.lover lover
  json.checked @user.checked_lover?(lover)
end