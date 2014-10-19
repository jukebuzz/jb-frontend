json.partial! 'users/user', user: @user
json.extract! @user, :active_balance
