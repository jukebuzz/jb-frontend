json.extract! room, :id, :name, :join_token
json.set! :owner do
  json.partial! 'users/user', user: room.owner
end
