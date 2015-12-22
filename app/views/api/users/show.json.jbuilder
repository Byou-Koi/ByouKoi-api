json.user @user
json.lovers @lovers do |lover|
  json.lover lover
  json.checked @user.checked_lover?(lover)
  json.room_token Room.get_room_token(@user.id, lover.id)
end