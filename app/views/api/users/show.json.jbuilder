json.user @user
json.longest_period @longest_periods
json.lovers @lovers do |lover|
  json.lover lover
  json.checked @user.checked_lover?(lover)
  json.room_token Room.get_room_token(@user.id, lover.id)
  json.last_message @user.last_message_text(lover)
end